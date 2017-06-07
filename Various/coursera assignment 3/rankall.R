rankall <- function(outcome, num) {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check that outcome is valid

        # if outcome is not "heart attack", "heart failure", or "pneumonia" 
        # stop with an error message
        if(outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia") {
                stop("invalid outcome")
        }
        
        
        ## Return hospital name in that state with the given rank 
        ## 30-day death rate
        
        
        ## Create subset of data based on input arguments
        
        # turn the input outcome to a column index (cause who can type that column name)
        if(outcome == "heart attack") {
                col_index <- 11
        }
        else if(outcome == "heart failure") {
                col_index <- 17
        }
        else if(outcome == "pneumonia") {
                col_index <- 23
        }
        
        # Create a new data frame, which is a subset of the original, 
        # with columns: hospital name, state, and input outcome.
        
        data_subset <- subset(data, select = c(Hospital.Name, State, col_index))
        
        # set the outcome column to numeric. In this data frame, outcome will be the 3rd column.
        # also suppress the warning that would be otherwise shown
        data_subset[, 3] = suppressWarnings(as.numeric(data_subset[, 3]))
        
        # exclude rows with missing values
        data_subset <- data_subset[complete.cases(data_subset), ]
        
        # sort it into ascending order (by state, then by outcome, and then by hospital name)
        ordered_subset <- data_subset[order(data_subset[2], data_subset[3], data_subset[1]), ]
        
        # Inside the following if statement, a "by list" is created, which is essentially the
        # ordered_subset split by the factor variable "state".
        # A function is also used to only keep the best/worst/"num" hospital for a single state.
        # The outcome column is removed.
        
        if(num == "best") {
                data_by_state <- by(ordered_subset, ordered_subset$State, function(x) {x[1, 1:2]})
        }
        else if(num == "worst") {
                data_by_state <- by(ordered_subset, ordered_subset$State, function(x) {x[nrow(x), 1:2]})
        }
        else { 
                data_by_state <- by(ordered_subset, ordered_subset$State, function(x) {x[num, 1:2]})
        }

        # The list is finally restructured to a data frame
        do.call(rbind, data_by_state)
}