zipFile <- "../household_power_consumption.zip"

if(!file.exists(zipFile)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest=zipFile)
}
  
unzip(zipFile)

library(dplyr)

hpow <- filter(mutate(fread("household_power_consumption.txt", na.strings="?", header=TRUE), date2:= as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))), date2 >= as.POSIXct("2007-02-01"), date2 < as.POSIXct("2007-02-03"))

plot.new()

png(filename = "plot4.png", width=480, height=480)

# set up canvas for 2 x 2 chart layout
par(mfrow=c(2,2))

# top left chart
with(hpow,plot(date2, Global_active_power, type="l", ylab="Global Active Power", xlab=""))

# top right chart
with(hpow,plot(date2, Voltage, type="l", ylab="Voltage", xlab="datetime"))

# bottom left chart
with(hpow, plot(date2, Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering"))

points(hpow$date2, hpow$Sub_metering_1, type="l", col="black")
points(hpow$date2, hpow$Sub_metering_2, type="l", col="red")
points(hpow$date2, hpow$Sub_metering_3, type="l", col="blue")

# add top right legend
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, bty="n")

#bottom right chart
with(hpow,plot(date2, Global_reactive_power, type="l", xlab="datetime"))

dev.off()