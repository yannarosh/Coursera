complete <- function(directory, id = 1:332) {
        all_files <- list.files(directory, full.names = TRUE)
        D = data.frame()
        
        for(i in id) {
                nobs = sum(complete.cases(read.csv(all_files[i])))
                tmp_D = data.frame(i , nobs)
                D = rbind(D, tmp_D)
        }
          
        D            
}