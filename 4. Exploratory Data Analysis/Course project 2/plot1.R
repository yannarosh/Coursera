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

# Create vector of aggregate values
# emissions converted to Kilotons for better scale
emissions_year <- tapply(data_raw$Emissions, data_raw$year, sum)
emissions_year_kt <- emissions_year / 1000

# plot
message("creating plot...")
png(filename = "./plot1.png")
barplot(emissions_year_kt, main = "Total PM2.5 Emissions by Year", xlab = "year", 
        ylab = "PM2.5 Emissions (Kt.)")

dev.off()