# greta.gam 0.2.1

This release restores `greta.gam` to CRAN. It was archived in September 2025 as
a consequence of the archival of its dependency, `greta`, which returned to CRAN
in version 0.6.0.

* Requires `greta` (>= 0.6.0), and has been tested against it.

* Fixed a bug in `smooths()` where formulas containing more than one smooth term
  with differing basis dimensions (e.g. `~ s(x, k = 5) + s(z, k = 10)`) would
  error with "distribution dimensions do not match implied dimensions". The
  basis dimension of the first smooth was being reused for every smooth in the
  formula.

* implement %||% internally to avoid NOTE since this function was only
  implemented in R 4.4.0 (#31)

* Updated the link to the `greta` website, which had moved, and pointed the
  Codecov badge at its current address.

# greta.gam 0.2.0

* Initial CRAN submission.
