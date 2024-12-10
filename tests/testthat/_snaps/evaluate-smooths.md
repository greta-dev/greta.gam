# evaluate_smooths errors appropriately

    Code
      evaluate_smooths("thing")
    Condition
      Error in `evaluate_smooths()`:
      ! Can only evaluate smooths from greta arrays created with `greta.gam::smooths()`

---

    Code
      (eval_z <- evaluate_smooths(z, newdata = data.frame(x = x_plot)))
    Message
      greta array <operation>
      
    Output
            [,1]
       [1,]  ?  
       [2,]  ?  
       [3,]  ?  
       [4,]  ?  
       [5,]  ?  
       [6,]  ?  
       [7,]  ?  
       [8,]  ?  
       [9,]  ?  
      [10,]  ?  
    Message
      
      i 190 more values
      Use `print(n = ...)` to see more values

