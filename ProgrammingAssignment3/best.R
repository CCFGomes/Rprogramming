best <- function(state, outcome) {
  data <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character", header = TRUE)
  
  fd <- as.data.frame(cbind(data[, "Hospital.Name"],
                            data[, "State"],
                            data[, 11],  # Column index for heart attack
                            data[, 17],  # Column index for heart failure
                            data[, 23]), # Column index for pneumonia
                      stringsAsFactors = FALSE)
  
  colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  if(!state %in% fd[, "state"]) {
    stop('invalid state')
  } else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop('invalid outcome')
  } else {
    si <- which(fd[, "state"] == state)
    ts <- fd[si, ]    # extracting data for the called state
    oi <- as.numeric(ts[, outcome])
    min_val <- min(oi, na.rm = TRUE)
    result <- ts[, "hospital"][which(oi == min_val)]
    output <- result[order(result)]
  }
  
  return(output)
}
 # Test the function
> best("TX", "heart attack")
[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
Warning message:
In best("TX", "heart attack") : NAs introduced by coercion
> 
> # Test the function
> best("NY", "heart attack")
[1] "NYU HOSPITALS CENTER"
Warning message:
In best("NY", "heart attack") : NAs introduced by coercion
> 
