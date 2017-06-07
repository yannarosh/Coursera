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

# Subset dataset to include only observations ON-ROAD from BC and LA
data_sub_onroad_BC_LA <- subset(data_raw, 
                                (data_raw$fips == "24510" | data_raw$fips == "06037") 
                                & (data_raw$type == "ON-ROAD"))

# create aggregate table and fix column names and change fips value to county name in rows.
agr_onroad_BC_LA <- aggregate(Emissions ~ year + fips, data = data_sub_onroad_BC_LA, sum)
colnames(agr_onroad_BC_LA) <- c("year", "County", "Emissions")
agr_onroad_BC_LA$County<- gsub("24510", "Baltimore City", agr_onroad_BC_LA$County)
agr_onroad_BC_LA$County<- gsub("06037", "Los Angeles County", agr_onroad_BC_LA$County)


# plot
require(ggplot2)
message("creating plot...")
png(filename = "./plot6.png")

g <- ggplot(data = agr_onroad_BC_LA, aes(as.factor(year), Emissions, fill = County))
g + geom_bar(stat = "identity") + facet_grid(County~., scales = "free") + xlab("year") + 
        ylab("PM2 Emissions (tons)") + 
        ggtitle("Total Emissions from motor vehicle sources in BC and LA")

dev.off()