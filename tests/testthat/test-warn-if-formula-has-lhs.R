test_that("warn_if_formula_has_lhs", {
  expect_snapshot_warning(
    warn_if_formula_has_lhs(y ~ x)
  )
  expect_no_warning(
    warn_if_formula_has_lhs(~x)
  )
})
