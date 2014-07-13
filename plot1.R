cat("Downloading and extracting files (if necessary) ...\n")
if(!file.exists("./data/household_power_consumption.txt")) {
  url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,destfile="./data/household_power_consumption.zip", method="curl")
  unzip("./data/household_power_consumption.zip", exdir = "./data")
}

cat("Installing and loading required packages...\n")
if("data.table" %in% rownames(installed.packages()) == FALSE) {
  install.packages("data.table")
}
library(data.table)

cat("Reading data from file. Please Wait!\n")
data <- fread("./data/household_power_consumption.txt", colClasses = "character", na.strings="?", sep=";", header = TRUE)
data$Date <- as.Date(data$Date, format= "%d/%m/%Y")

cat("Subsetting required data for plot.\n")
sub <- subset( data, Date == as.Date("2007-02-01") )
sub2 <- subset( data, Date == as.Date("2007-02-02") )
data_sub <- rbind(sub,sub2)

cat("Plotting histogram...\n")
par(mfrow=c(1,1), cex=0.80)
hist(as.numeric(data_sub$Global_active_power), main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png,file="./plot1.png",height=480, width=480)

cat("plot1.png saved in working directory in path:", getwd(),"\n" )
dev.off()