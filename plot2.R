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
data_sub[ , DateTime := as.POSIXct(paste(Date,Time), format = "%Y-%m-%d %H:%M:%S")]

cat("Plotting line graph...\n")
par(mfrow=c(1,1), cex=0.80)
plot(data_sub$DateTime, data_sub$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png,file="./plot2.png",height=480, width=480)

cat("plot2.png saved in working directory in path:", getwd(),"\n" )
dev.off()