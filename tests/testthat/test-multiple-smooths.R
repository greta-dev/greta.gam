test_that("smooths() handles several smooths with differing basis dimensions", {
  skip_if_not(check_tf_version())

  set.seed(2026 - 07 - 21)
  dat <- mgcv::gamSim(1, n = 100, dist = "normal", scale = 1, verbose = FALSE)

  # a single smooth still works
  z_one <- smooths(~ s(x0), data = dat)
  expect_s3_class(z_one, "greta_array")
  expect_equal(dim(z_one), c(100, 1))

  # two smooths sharing a basis dimension
  z_same <- smooths(~ s(x0) + s(x1), data = dat)
  expect_s3_class(z_same, "greta_array")
  expect_equal(dim(z_same), c(100, 1))

  # two smooths with *differing* basis dimensions previously errored, because
  # the basis dimension of the first smooth was reused for every smooth
  z_diff <- smooths(~ s(x0, k = 5) + s(x1, k = 10), data = dat)
  expect_s3_class(z_diff, "greta_array")
  expect_equal(dim(z_diff), c(100, 1))

  # one coefficient per column of the design matrix
  info <- attr(z_diff, "smooth_info")
  expect_equal(dim(info$betas)[1], ncol(info$X))
})
