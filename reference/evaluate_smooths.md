# evaluate smooths at new data

Evaluate a set of smooths at new data locations

## Usage

``` r
evaluate_smooths(x, newdata)
```

## Arguments

- x:

  a greta array created with greta.gam::smooths

- newdata:

  a dataframe with the same column names and datatypes as that used to
  create x, with data at which to evaluate the smooths

## Value

greta array

## Author

Nick Golding

## Examples

``` r
if (FALSE) { # \dontrun{
n <- 30
x <- runif(n, 0, 10)
f <- function(x) {
  sin(x * 2) + 1.6 * (x < 3) - 1.4 * (x > 7)
}
y <- f(x) + rnorm(n, 0, 0.3)
x_plot <- seq(0, 10, length.out = 200)

z <- smooths(~ s(x), data = data.frame(x = x))

distribution(y) <- normal(z, 0.3)

z_pred <- evaluate_smooths(z, newdata = data.frame(x = x_plot))

z_pred
} # }
```
