test_that("evaluate_smooths errors appropriately", {
  expect_snapshot_error(
    evaluate_smooths("thing")
  )
})
