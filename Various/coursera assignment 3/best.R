best <- function(state, outcome) {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

        ## Check that state and outcome are valid
                # if state doesn't exist stop with an error message
        if(!state %in% data$State) {
                stop("invalid state")
        }

                # if outcome is not either "heart attack", "heart failure", or "pneumonia" 
                # stop with a different error message
        if(outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia") {
                stop("invalid outcome")
        }
        

        ## Return hospital name in that state with lowest 30-day death
        ## rate
        
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
                # with columns: hospital name, state, and input outcome, only for rows corresponding to input state
        
        data_subset <- subset(data, State == state, select = c(Hospital.Name, State, col_index))
                
                # set the outcome column to numeric. In this data frame, outcome will be the 3rd column.
                # also suppress the warning that would be otherwise shown
        data_subset[, 3] = suppressWarnings(as.numeric(data_subset[, 3]))
        
                # exclude rows with missing values
        data_subset <- data_subset[complete.cases(data_subset), ]
        
                # sort it into ascending order (by outcome and then by hospital name)
        ordered_subset <- data_subset[order(data_subset[3], data_subset[1]), ]

        
        ## Return result hospital, which is found in the first row of the ordered subset
        ordered_subset[1, 1]
}