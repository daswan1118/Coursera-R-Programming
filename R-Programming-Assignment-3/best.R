##### Best Hospital in State #####

## The function reads the outcome-of-care-measures.csv file and returns a character vector
## with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
## in that state. 


best <- function (state,condition) {
  
  # Read Data
  options(warn=-1)
  outcome <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
  outcome[,11] <- as.numeric(outcome[,11])
  names(outcome) <- tolower(names(outcome))
  
  # Subset Data based on conditions
  col_nm <- paste('hospital.30.day.death..mortality..rates.from.', sub(' ', '.', condition), sep='')
  outcome <- outcome[,c('hospital.name','state',col_nm)]
  outcome <- outcome[complete.cases(outcome),]
  outcome[,c(col_nm)] <- as.numeric(outcome[,c(col_nm)])
  outcome <- outcome[outcome$state == state,]
  
  # Check that state and outcome are valid
  if (!(state %in% state.abb)) return('invalid state')
  if (!(condition %in% c('heart attack','heart failure', 'pneumonia'))) return('invalid outcome')

  # Return hospital name in the state with lowest 30-day rate
  outcome <- outcome[order(outcome[,c(col_nm)],outcome$hospital.name),]
  tryCatch(outcome$rank <- 1:nrow(outcome), error=function(err) NA)
  return(outcome[which(outcome$rank == 1),]$hospital.name)
  
  options(warn=0)
}

