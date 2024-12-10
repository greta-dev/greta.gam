n <- 30
x <- runif(n, 0, 10)
f <- function(x) {
  sin(x * 2) + 1.6 * (x < 3) - 1.4 * (x > 7)
}
y <- f(x) + rnorm(n, 0, 0.3)
x_plot <- seq(0, 10, length.out = 200)

z <- smooths(~ s(x), data = data.frame(x = x))

distribution(y) <- normal(z, 0.3)

test_that("evaluate_smooths errors appropriately", {
  expect_snapshot(
    error = TRUE,
    evaluate_smooths("thing")
  )
  expect_no_error(
    z_pred <- evaluate_smooths(z, newdata = data.frame(x = x_plot))
  )
})
