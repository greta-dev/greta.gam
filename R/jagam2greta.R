#' Turn a jagam model definition into a greta model definition
#'
#' Takes a GAM defined by `formula` and returns the corresponding `greta` model
#'   via the power of `jagam`. Response variable is generated from dummy data
#'   and not used.
#'
#' @inheritParams smooths
#' @param newdata new dataset
#'
#' @return a `list` with the following elements: `betas` a greta array for
#'   the coefficients to be estimated (with appropriate priors applied), `X`
#'   design matrix for this model, `X_pred` prediction matrix.
#' @keywords internal
#' @noRd
#' @examples
#' \dontrun{
#' n <- 30
#'
#' x <- runif(n, 0, 10)
#'
#' f <- function(x) {
#'   sin(x * 2) + 1.6 * (x < 3) - 1.4 * (x > 7)
#' }
#'
#' y <- f(x) + rnorm(n, 0, 0.3)
#'
#' x_plot <- seq(0, 10, length.out = 200)
#'
#' jagam2greta(
#'   formula = ~ s(x),
#'   data = data.frame(x = x),
#'   tol = 0
#' )
#' }
#'
jagam2greta <- function(formula,
                        data,
                        newdata,
                        sp = NULL,
                        knots = NULL,
                        tol = 0) {
  # make a dummy response to get jagam to work
  formula <- stats::update(formula, dummy ~ .)

  stop_when_dummy_in_data(data)

  data$dummy <- rep(1, nrow(data))

  # do the jagam call, store the JAGS code gets stored in jags_spec
  jags_spec <- ""
  jags_stuff <- mgcv::jagam(
    formula = formula,
    data = data,
    family = stats::gaussian(),
    knots = knots,
    file = textConnection(
      "jags_spec",
      open = "a",
      local = TRUE
    )
  )

  warn_if_offsets_present(jags_stuff)

  # this is the design matrix for EVERYTHING (not per smooth)
  # need to think about this more carefully for multiple smooths?
  X <- jags_stuff$jags.data$X

  # do something smart with smoothing parameters
  n_smooth_params <- length(jags_stuff$pregam$smooth)
  sp <- sp %||% gamma(0.05, 1 / 0.005, dim = 2 * n_smooth_params)

  # get all the penalties, form them (because of proper priorness), then
  # turn them into vcov matrices via solve()
  Kthings <- jags_spec[grepl("^  K", jags_spec)]
  Kthings <- gsub("lambda", "sp", Kthings)
  Ktosolve <- sub("^  K(\\d+).*", "\\1", Kthings)
  for (i in seq_along(Kthings)) {
    thisK <- paste0("K", Ktosolve[i])
    # run the K <- S[]*sp[1] + S[]*sp[2] line
    assign(thisK, with(jags_stuff$jags.data, eval(parse(text = Kthings[i]))))
    # solve line
    assign(thisK, solve(get(paste0("K", Ktosolve[i]))))

    # add optional jitter
    if (tol > 0) {
      assign(thisK, get(thisK) + diag(nrow(get(thisK))) * tol)
    }
    # prior on betas
    # beta <- t(multivariate_normal(zeros(dim), K))
    assign(
      paste0("b", Ktosolve[i]),
      t(multivariate_normal(
        zeros(1, jags_stuff$pregam$smooth[[1]]$df),
        get(thisK)
      ))
    )
    # put the betas together
    if (i == 1) {
      betas <- get(paste0("b", Ktosolve[i]))
    } else {
      betas <- c(betas, get(paste0("b", Ktosolve[i])))
    }
  }

  # do intercept stuff
  int <- normal(0, 1.3)

  # put all the betas together
  betas <- c(int, betas)

  return(list(
    betas = betas,
    X = X,
    smooth_list = jags_stuff$pregam$smooth
  ))
}
