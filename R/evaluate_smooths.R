#' @title evaluate smooths at new data
#'
#' @description Evaluate a set of smooths at new data locations
#'
#' @param x a greta array created with greta.gam::smooths
#' @param newdata a dataframe with the same column names and datatypes as that
#'   used to create x, with data at which to evauate the smooths
#' @return
#' @author Nick Golding
#' @importFrom mgcv PredictMat
#' @export
evaluate_smooths <- function(x, newdata) {
  info <- attr(x, "smooth_info")
  if (is.null(info)) {
    stop("can only evaluate smooths from greta arrays created with greta.gam::smooths",
      call. = FALSE
    )
  }

  X_pred <- c()
  for (i in seq_along(info$smooth_list)) {
    # make X_pred
    X_pred <- cbind(X_pred, PredictMat(info$smooth_list[[i]], newdata))
  }
  X_pred <- cbind(1, X_pred)

  X_pred %*% info$betas
}
