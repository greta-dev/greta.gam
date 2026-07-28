## Test environments

* local macOS (aarch64-apple-darwin23), R 4.6.1
* win-builder (devel)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Submission notes

* This is a resubmission of a package that was archived on 2025-09-20.

* `greta.gam` was archived solely as a consequence of the archival of its
  dependency, `greta`. `greta` has since been repaired and accepted back on
  CRAN as version 0.6.0. Nothing was wrong with `greta.gam` itself.

* `greta.gam` now depends on `greta` (>= 0.6.0), and has been checked and
  tested against that version, along with `mgcv` 1.9-4.

* `greta` performs its computation via TensorFlow in Python, which is not
  available on CRAN's check machines. Accordingly:
  * Examples that need to fit a model are wrapped in `\dontrun{}`, as they
    cannot run without a working Python installation.
  * Vignette chunks and tests that require TensorFlow are guarded and are
    skipped when it is unavailable, so the package checks cleanly on machines
    without Python.
  This is the same arrangement used by `greta` itself and accepted in the
  previous submission of this package.

* On systems where TensorFlow is present, its "autograph" component can leave
  generated `.py` files and a `__pycache__` directory in the session temp
  directory, which R CMD check may report as detritus. This did not occur in
  the checks above, but should it appear on a check machine, it originates in
  TensorFlow rather than in `greta.gam`.
