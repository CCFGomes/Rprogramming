# 1 Plot the 30-day mortality rates for heart attack
# Read the outcome data into R via the read.csv function and look at the first few rows.
> outcome_of_care_measures <- read_csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv")
Rows: 4706 Columns: 46                                                                                                         
── Column specification ───────────────────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
chr (43): Provider Number, Hospital Name, Address 1, City, State, ZIP Code, County Name, Hospital 30-Day Death (Mortality) ...
dbl  (1): Phone Number
lgl  (2): Address 2, Address 3

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> outcome_of_care_measures[, 11] <- as.numeric(outcome_of_care_measures[, 11])
Error: 'list' object cannot be coerced to type 'double'

> outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character",header=TRUE)
Error in file(file, "rt") : cannot open the connection
In addition: Warning message:
In file(file, "rt") :
  cannot open file 'outcome-of-care-measures.csv': No such file or directory

> outcome <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character",header=TRUE)
> outcome[, 11] <- as.numeric(outcome[, 11],na.rm=TRUE)
Warning message:
NAs introduced by coercion 
> hist(outcome[, 11],xlab= "Deaths", main = "Hospital 30-Day Death (Mortality) Rates from Heart Attack")

# check the histogram at https://github.com/CCFGomes/Rprogramming/blob/Data_Analysis/ProgrammingAssignment3/Rplot%20-%2030-day%20death%20rates%20from%20heart%20attack.png
