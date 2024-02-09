test_df <- data.frame(
  dummy = 1:5,
  thing = LETTERS[1:5]
)

test_that("stop_when_dummy_in_data errors appropriately", {
  expect_snapshot_error(
    stop_when_dummy_in_data(test_df)
  )

  expect_no_error(
    stop_when_dummy_in_data(mtcars)
  )
})
