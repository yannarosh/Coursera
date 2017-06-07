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