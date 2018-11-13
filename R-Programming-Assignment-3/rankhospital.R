##### Ranking Hospitals by Outcome in a State #####

## The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
## of the hospital that has the ranking specified by the num argument. 


rankhospital <- function (state,condition,rank='best') {
  
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
  if (rank == 'best') rank <- 1
  if (rank == 'worst') rank <- as.numeric(nrow(outcome))
  
  # Return hospital name in the state with given rank
  outcome <- outcome[order(outcome[,c(col_nm)],outcome$hospital.name),]
  tryCatch(outcome$rank <- 1:nrow(outcome), error=function(err) NA)
  return(outcome[which(outcome$rank == rank),]$hospital.name)

  options(warn=0)
}

