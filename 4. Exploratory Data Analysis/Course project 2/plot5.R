# download and unzip files 
if(!file.exists("./assignment_data")) {
        dir.create("./assignment_data")
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        file_dest <- "./assignment_data/assignment_data.zip"
        message("downloading files...")
        download.file(url, file_dest)
        message("unzipping contents...")
        unzip("./assignment_data/assignment_data.zip", exdir = "./assignment_data")
}

# read files into objects        
message("reading data...")
data_raw <- readRDS('./assignment_data/summarySCC_PM25.rds')
SCC <- readRDS('./assignment_data/Source_Classification_Code.rds')

# merge the two datasets and select only observations ON-ROAD from Baltimore
data_sub_onroad_BC <- subset(data_raw, (data_raw$fips == "24510") & (data_raw$type == "ON-ROAD"))

# create aggregate table
agr_onroad_BC <- aggregate(Emissions ~ year, data = data_sub_onroad_BC, sum)

# plot
require(ggplot2)
message("creating plot...")
png(filename = "./plot5.png")

g <- ggplot(data = agr_onroad_BC, aes(as.factor(year), Emissions))
g + geom_bar(stat = "identity") + xlab("year") + ylab("PM2 Emissions (tons)") + 
        ggtitle("Total Emissions from motor vehicle sources in Baltimore City")

dev.off()