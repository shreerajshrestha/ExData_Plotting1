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

cat("Installing required packages (if necessary)...\n")
if("data.table" %in% rownames(installed.packages()) == FALSE) {
  install.packages("plyr")
}

cat("Reading data from file. Please Wait!\n")
data<-fread("./data/household_power_consumption.txt", colClasses = "character", na.strings="?", sep=";", header = TRUE)
data$Date <- as.Date(data$Date, format= "%d/%m/%Y")

cat("Subsetting required data for plot.\n")
sub <- subset( data, Date == as.Date("2007-02-01") )
sub2 <- subset( data, Date == as.Date("2007-02-02") )
data_sub <- rbind(sub,sub2)
data_sub[ , datetime := as.POSIXct(paste(Date,Time), format = "%Y-%m-%d %H:%M:%S")]

cat("Plotting multi graph...\n")
par(mfrow=c(2,2), cex=0.80)
with( data_sub, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with( data_sub, plot(datetime, Voltage, type="l", xlab="datetime"))
with( data_sub, plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with( data_sub, lines(datetime, Sub_metering_2, type="l", col = "red") )
with( data_sub, lines(datetime, Sub_metering_3, type="l", col = "blue") )
legend( "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n", lty = rep(1,times=3), col=c("black","blue","red"), y.intersp = 0.25, cex = 0.80, adj = 0.1)
with( data_sub, plot(datetime, Global_reactive_power, type="l"))

dev.copy(png,file="./plot4.png",height=480, width=480)
cat("plot4.png saved in working directory in path:", getwd(),"\n" )
dev.off()