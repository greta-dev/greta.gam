#' @title greta array representations of mgcv smooth terms
#'
#' @name smooths
#'
#' @description \code{smooths} translates the right hand side of a mgcv GAM
#'   formula into a corresponding Bayesian representation of smooth terms. This
#'   formula may include multiple combined smooths of different types, as well
#'   as fixed effect terms and intercepts. The resulting greta array
#'   representing the combined smooth can then be used in a greta model.
#'
#' @param formula a GAM formula representing the smooth terms, as in
#'   \code{\link[mgcv:gam]{mgcv::gam}}. Only the right hand side fo the formula
#'   will be used.
#'
#' @param data a data frame or list containing the covariates required by the
#'   formula. These covariates cannot be greta arrays.
#'
#' @param knots an optional list containing user specified knot values to be
#'   used for basis construction, as in \code{\link[mgcv:gam]{mgcv::gam}} These
#'   knots cannot be greta arrays.
#'
#' @param sp an optional vector of smoothing parameters, two per smooth term in
#'   the model, in the same order as the formula. If \code{sp = NULL}, all
#'   smoothing parameters will be learned, otherwise all smoothing parameters
#'   must be specified by the user. The smoothing parameters may either be a
#'   numeric vector or a greta array (which could be a variable).
#'
#' @details Only the right hand side of \code{formula} will be used to define
#'   the smooth terms. The user must complete the gam model by specifying the
#'   link and likelihood term in greta. A warning will be issued if the formula
#'   has a left hand side.
#'
#'   Note that by default, GAM formulas add an intercept term. If you have
#'   already specified an intercept for your greta model, you can remove the
#'   intercept from the smooth term by adding \code{-1} as a term in your
#'   formula.
#'
#'   Like \code{\link[mgcv:jagam]{mgcv::jagam}}, \code{smooths} translates a
#'   mgcv GAM formula into a Bayesian representation of the smooth terms, using
#'   the GAM smoothing penalty matrix as a multivariate normal prior to penalise
#'   model fitting. Unlike \code{gam}, \code{smooths} does not perform the
#'   integration required to penalise model fitting. The model must be fitted by
#'   MCMC to carry out this integration - it does not make sense to do maximum
#'   likelihood optimisation on a greta model that uses \code{smooths}.
#'
#' @importFrom mgcv gam
smooths <- function (formula, data = list(), knots = NULL, sp = NULL) {

  if (length(formula) > 2) {
    warning ("the formula has a left hand side, only the right hand side ",
             "will be used to define the smooth",
             call. = FALSE)
  }

  gam <- mgcv::gam(formula = formula,
                   knots = knots,
                   fit = FALSE)

  jagam2greta(gam, sp)

}
