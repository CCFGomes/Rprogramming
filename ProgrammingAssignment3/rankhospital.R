# create a rankhospital function
rankhospital <- function(state, outcome, rank = "best"){
  ## Read outcome data
  data <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", stringsAsFactors = FALSE)
  fd   <- as.data.frame(cbind(data[, 2],  # hospital
                              data[, 7],  # state
                              data[, 11],  # heart attack
                              data[, 17],  # heart failure
                              data[, 23]), # pneumonia
                        stringsAsFactors = FALSE)
  colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  ## Check that state and outcome are valid
  if (!state %in% fd[, "state"]) {
    stop('invalid state')
  } else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  } else if (is.numeric(rank)) {
    si <- which(fd[, "state"] == state)
    ss <- fd[si, ]                     # extracting dataframe for the called state
    ss[, eval(outcome)] <- as.numeric(ss[, eval(outcome)])
    ss <- ss[order(ss[, eval(outcome)], ss[, "hospital"]), ]
    output <- ss[, "hospital"][rank]
  } else if (!is.numeric(rank)){
    if (rank == "best") {
      output <- best(state, outcome)
    } else if (rank == "worst") {
      si <- which(fd[, "state"] == state)
      ss <- fd[si, ]    
      ss[, eval(outcome)] <- as.numeric(ss[, eval(outcome)])
      ss <- ss[order(ss[, eval(outcome)], ss[, "hospital"], decreasing = TRUE), ]
      output <- ss[, "hospital"][1]
    } else {
      stop('invalid rank')
    }
  }
  return(output)
}

# Testing rankhospital.R
> rankhospital("TX", "heart failure", 4)
[1] "DETAR HOSPITAL NAVARRO"
Warning message:
In rankhospital("TX", "heart failure", 4) : NAs introduced by coercion
> rankhospital("NY", "heart failure", 4)
[1] "VA NEW YORK HARBOR HEALTHCARE SYSTEM - NY DIV."
Warning message:
In rankhospital("NY", "heart failure", 4) : NAs introduced by coercion
> rankhospital("MD", "heart attack", "worst")
[1] "HARFORD MEMORIAL HOSPITAL"
Warning message:
In rankhospital("MD", "heart attack", "worst") : NAs introduced by coercion
> rankhospital("MN", "heart attack", 5000)
[1] NA
Warning message:
In rankhospital("MN", "heart attack", 5000) : NAs introduced by coercion
