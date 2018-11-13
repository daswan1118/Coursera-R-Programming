##### Ranking hospitals in all state #####

## The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
## containing the hospital in each state that has the ranking specified in num
 
rankall <- function (condition,rank='best') {
  
  library(dplyr)
  
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
  
  # Check that state and outcome are valid
  if (!(condition %in% c('heart attack','heart failure', 'pneumonia'))) return('invalid outcome')
  if (rank == 'best') rank <- 1
  
  # Return hospital name in the state with given rank
  outcome <- outcome[order(outcome$state,outcome[,c(col_nm)],outcome$hospital.name),]
  outcome <- tryCatch(outcome %>% 
             group_by(state) %>% 
             mutate(rank = 1:n()) %>% 
             ungroup(), error=function(err) NA)
  if (is.numeric(rank)) {
    result <- outcome[outcome$rank == rank,]
    result <- result[,c('hospital.name','state')]
    return(result)
  } else if (rank == 'worst') {
    result <- outcome %>% 
      group_by(state) %>%
      filter(rank == max(rank))
    result <- result[,c('hospital.name','state')]
    return(result)
  }
  
  options(warn=0)
}
