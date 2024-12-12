#' @title evaluate smooths at new data
#'
#' @description Evaluate a set of smooths at new data locations
#'
#' @param x a greta array created with greta.gam::smooths
#' @param newdata a dataframe with the same column names and datatypes as that
#'   used to create x, with data at which to evaluate the smooths
#' @return greta array
#' @author Nick Golding
#' @examples
#' \dontrun{
#' n <- 30
#' x <- runif(n, 0, 10)
#' f <- function(x) {
#'   sin(x * 2) + 1.6 * (x < 3) - 1.4 * (x > 7)
#' }
#' y <- f(x) + rnorm(n, 0, 0.3)
#' x_plot <- seq(0, 10, length.out = 200)
#'
#' z <- smooths(~ s(x), data = data.frame(x = x))
#'
#' distribution(y) <- normal(z, 0.3)
#'
#' z_pred <- evaluate_smooths(z, newdata = data.frame(x = x_plot))
#'
#' z_pred
#'}
#' @export
evaluate_smooths <- function(x, newdata) {
  info <- attr(x, "smooth_info")

  stop_if_no_smooth_info(info)

  X_pred <- matrix(numeric(), nrow = nrow(newdata))
  for (i in seq_along(info$smooth_list)) {
    # make X_pred
    X_pred <- cbind(X_pred, mgcv::PredictMat(info$smooth_list[[i]], newdata))
  }
  X_pred <- cbind(1, X_pred)

  X_pred %*% info$betas
}
