## greta.gam

#### Generalised additive models in greta using mgcv.

greta.gam lets you use [mgcv](https://CRAN.R-project.org/package=mgcv)'s smoother functions and formula syntax to define smooth terms for use in a [greta](https://greta-dev.github.io/greta) model.
You can then define your own likelihood to complete the model, and fit it by MCMC.

This is work in progress and is not yet ready for use!

More details and examples will follow.


#### Brief technical details

`greta.gam` uses a few tricks from the `jagam` routine in `mgcv` to get things to work. Here are some brief details for those interested in the internal workings...

**Bayesian interpretation of the GAM**: GAMs are, of course, Bayesian models. One can think of the smoother penalty matrix as a prior covariance matrix (they are inverses of each other) in a Bayesian random effects model. Design matrices are constructed exactly as in the frequentist case.

**Penalty matrices**: There is a slight difficulty in the Bayesian interpretation of the GAM in that, in their naïve form the priors are improper as the nullspace of the penalty (in the 1D case, usually the linear term). To get proper priors we can use one of the "tricks" employed in Marra & Wood (2011) -- that is to somehow penalise the parts of the penalty that lead to the improper prior. We take the option provided by `jagam` and create an additional penalty matrix for these terms (from an eigen-decomposition of the penalty matrix; see Marra & Wood, 2011).


**References**:

Marra, G. and Wood, S.N. (2011) Practical variable selection for generalized additive models. Computational Statistics and Data Analysis, 55, 2372–2387.
