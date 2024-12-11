test_that("evaluate_smooths errors appropriately", {
  skip_if_not(check_tf_version())
  n <- 30
  x <- runif(n, 0, 10)
  f <- function(x) {
    sin(x * 2) + 1.6 * (x < 3) - 1.4 * (x > 7)
  }
  y <- f(x) + rnorm(n, 0, 0.3)
  x_plot <- seq(0, 10, length.out = 200)

  z <- smooths(~ s(x), data = data.frame(x = x))

  distribution(y) <- normal(z, 0.3)


  expect_snapshot(
    error = TRUE,
    evaluate_smooths("thing")
  )
  expect_snapshot(
    (eval_z <- evaluate_smooths(z, newdata = data.frame(x = x_plot)))
  )

  expect_s3_class(
    object = eval_z,
    "greta_array"
  )

  expect_s3_class(
    object = eval_z,
    "array"
  )

  expect_equal(
    object = dim(eval_z),
    expected = c(200, 1)
  )

})
