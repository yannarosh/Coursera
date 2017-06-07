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

# subset to include only observations from Baltimore City

data_sub_BC <- subset(data_raw, data_raw$fips == "24510")

# create aggregate table
agr_BC <- aggregate(Emissions ~ year + type, data = data_sub_BC, sum)

# plot
require(ggplot2)
message("creating plot...")
png(filename = "./plot3.png")

g <- ggplot(data = agr_BC, aes(year, Emissions, col = type))
g + geom_line() + ylab("PM2.5 Emissions (tons)") + ggtitle("Total PM2.5 Emissions by type in Baltimore City")

dev.off()