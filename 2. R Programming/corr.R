corr <- function(directory, threshold = 0) {
        
        all_files <- list.files(directory, full.names = TRUE)
        
        # Use complete() to get a data frame with file indices and no. of complete cases in rach
       
         source("complete.R")
        D <- complete(directory)
        
        
        # Find which monitors have a no. of complete cases > threshold and store indices in a vector
        
        monOverThresh <- D[D$nobs > threshold, 1]
        
        
        # Initialize correlation vector as numeric
        
        correlations <- vector(mode = "numeric", length = 0)
        
        
        # Construct full dataset from all monitors with completed cases > threshold.
        
        for(i in monOverThresh) {
                A <- read.csv(all_files[i])             # Read data of ith monitor
                completeA <- complete.cases(A)          # Keep only complete cases

                sulfateData <- A[completeA, "sulfate"]              # Create vectors containing sulfate
                nitrateData <- A[completeA, "nitrate"]              # and nitrate data
                
                correlations[i] <- cor(x = sulfateData, y = nitrateData)        # Calculate correlation for monitor i
                
        }
       
        #Return the correlations vector, after removing NAs (corresponding to monitors that weren't above the threshold).
        
        correlations <- correlations[complete.cases(correlations)]
        print(correlations)
}