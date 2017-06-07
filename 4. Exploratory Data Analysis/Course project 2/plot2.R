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

# create vector of aggregate values
emissions_year_BC <- tapply(data_sub_BC$Emissions, data_sub_BC$year, sum)

# plot
message("creating plot...")
png(filename = "./plot2.png")
barplot(emissions_year_BC, main = "Total PM2.5 Emissions by year in Baltimore City", xlab = "year", 
        ylab = "PM2.5 Emissions (tons)")

dev.off()