pollutantmean <- function(directory, pollutant, id = 1:332) {
         all_files <- list.files(directory, full.names = TRUE)      
         A <- data.frame()
         
         for (i in id) {
                 A <- rbind(A, read.csv(all_files[i]) )
         }
         
         mu <- mean(A[, pollutant], na.rm = TRUE)
         print(mu)
}

