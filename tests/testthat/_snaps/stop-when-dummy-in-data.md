# stop_when_dummy_in_data errors appropriately

    Code
      stop_when_dummy_in_data(test_df)
    Condition
      Error:
      ! Data cannot already contain column named `dummy`
      i Rename existing column, perhaps to `dummy1`

---

    Code
      smooths(~ s(dummy), data = data.frame(dummy = x))
    Condition
      Error in `jagam2greta()`:
      ! Data cannot already contain column named `dummy`
      i Rename existing column, perhaps to `dummy1`

