# download and unzip files 
if(!file.exists("./data")) {
        dir.create("./data")
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        file_dest <- "./data/assignment_data.zip"
        message("downloading files...")
        download.file(url, file_dest)
        message("unzipping contents...")
        unzip("./data/assignment_data.zip", exdir = "./data")
}

# read files into objects        
message("reading data...")
data_raw <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

# merge the two datasets and select only coal related observations.
data_full <- merge(data_raw, SCC, by = "SCC")
coal_rows <- grepl("Fuel Comb.*Coal", data_full$EI.Sector)
data_full_coal <- data_full[coal_rows, ]

# create aggregate table
agr_coal <- aggregate(Emissions ~ year, data = data_full_coal, sum)

# plot
require(ggplot2)
message("creating plot...")
png(filename = "./plot4.png")

g <- ggplot(data = agr_coal, aes(as.factor(year), Emissions/1000))
g + geom_bar(stat = "identity") + xlab("year") + ylab("PM2 Emissions (Kt.)") + 
        ggtitle("Total Emissions from coal combustion-related sources")

dev.off()