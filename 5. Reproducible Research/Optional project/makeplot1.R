setwd("C:/Users/perre/Desktop/Coursera/Data Science/5. Reproducible Research/Opt. Assignment")

A <- read.csv("_e143dff6e844c7af8da2a4e71d7c054d_payments.csv")

pdf("plot1.pdf")
plot(log10(A$Average.Covered.Charges), log10(A$Average.Total.Payments), 
     col = "blue", 
     main = "Mean covered charges vs. Mean total payments", 
     xlab = "mean covered charges (log)", ylab = "mean total payments (log)")
dev.off()

