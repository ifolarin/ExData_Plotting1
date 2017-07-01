zipFile <- "../household_power_consumption.zip"

if(!file.exists(zipFile)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest=zipFile)
}
  
unzip(zipFile)

library(dplyr)

hpow <- filter(mutate(fread("household_power_consumption.txt", na.strings="?", header=TRUE), date2:= as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))), date2 >= as.POSIXct("2007-02-01"), date2 < as.POSIXct("2007-02-03"))

png(filename = "plot3.png", width=480, height=480)

# set up the chart / device but no plot
plot(hpow$date2, hpow$Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering")

# plot lines on graph
points(hpow$date2, hpow$Sub_metering_1, type="l", col="black")
points(hpow$date2, hpow$Sub_metering_2, type="l", col="red")
points(hpow$date2, hpow$Sub_metering_3, type="l", col="blue")

# add top right legend
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1)

dev.off()