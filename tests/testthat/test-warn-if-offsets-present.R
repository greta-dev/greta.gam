test_that("warn_if_offsets_present works", {
  jags_spec <- ""
  jags_stuff <- mgcv::jagam(
    formula = mpg ~ s(disp) + offset(wt),
    data = mtcars,
    family = stats::gaussian(),
    knots = NULL,
    file = textConnection(
      "jags_spec",
      open = "a",
      local = TRUE
    )
  )

  expect_snapshot(
    warn_if_offsets_present(jags_stuff)
  )
})
