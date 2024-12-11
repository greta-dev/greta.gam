test_that("stop_when_dummy_in_data errors appropriately", {
  skip_if_not(check_tf_version())

  test_df <- data.frame(
    dummy = 1:5,
    thing = LETTERS[1:5]
  )

  n <- 30
  x <- runif(n, 0, 10)
  f <- function(x) {
    sin(x * 2) + 1.6 * (x < 3) - 1.4 * (x > 7)
  }
  y <- f(x) + rnorm(n, 0, 0.3)
  x_plot <- seq(0, 10, length.out = 200)

  z <- smooths(~ s(x), data = data.frame(x = x))

  expect_snapshot(
    error = TRUE,
    stop_when_dummy_in_data(test_df)
  )

  expect_no_error(
    stop_when_dummy_in_data(mtcars)
  )

  expect_snapshot(
    error = TRUE,
    smooths(~ s(dummy), data = data.frame(dummy = x))
  )

})
