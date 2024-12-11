stop_if_no_smooth_info <- function(info,
                                   arg = rlang::caller_arg(info),
                                   call = rlang::caller_env()) {
  if (is.null(info)) {
    cli::cli_abort(
      c(
        "Can only evaluate smooths from greta arrays created with \\
        {.fn greta.gam::smooths}"
      ),
      call = call
    )
  }
}

stop_when_dummy_in_data <- function(data,
                                    arg = rlang::caller_arg(data),
                                    call = rlang::caller_env()) {
  if ("dummy" %in% colnames(data)) {
    cli::cli_abort(
      c(
        "Data cannot already contain column named {.var dummy}",
        "i" = "Rename existing column, perhaps to {.var dummy1}"
      ),
      call = call
    )
  }
}

warn_if_offsets_present <- function(jags_stuff,
                                    call = rlang::caller_arg(jags_stuff),
                                    env = rlang::caller_env()) {
  if (!is.null(jags_stuff$jags.data$offset)) {
    cli::cli_warn(
      c(
        "Offsets are not directly handled",
        "Remember to write them into your linear predictor!"
      ),
      call = call
    )
  }
}

warn_if_formula_has_lhs <- function(formula,
                                    arg = rlang::caller_arg(formula),
                                    call = rlang::caller_env()) {
  has_lhs <- rlang::is_formula(formula, lhs = TRUE)
  if (has_lhs) {
    cli::cli_warn(
      c(
        "Formula has a left hand side",
        "Only the right hand side will be used to define the smooth"
      ),
      call = call
    )
  }
}

check_if_formula <- function(formula,
                             arg = rlang::caller_arg(formula),
                             call = rlang::caller_env()){
  not_formula <- !rlang::is_bare_formula(formula)
  if (not_formula) {
    cli::cli_abort(
      c(
        "Input must be a formula",
        "We see that {.code formula} has class, {.cls {class(formula)}}."
      ),
      call = call
    )
  }
}
