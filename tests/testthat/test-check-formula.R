test_that("check_if_formula works", {
  expect_snapshot(
    error = TRUE,
    check_if_formula("potato")
  )
  expect_snapshot(
    error = TRUE,
    check_if_formula("y~x")
  )
  expect_no_error(
    check_if_formula(y~x)
  )
  expect_no_error(
    check_if_formula(y~s(x))
  )
})
