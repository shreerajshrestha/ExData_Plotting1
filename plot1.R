cat("Installing required packages (if necessary)...\n")
if("data.table" %in% rownames(installed.packages()) == FALSE) {
  install.packages("plyr")
}

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