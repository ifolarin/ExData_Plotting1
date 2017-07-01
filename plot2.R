zipFile <- "../household_power_consumption.zip"

if(!file.exists(zipFile)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest=zipFile)
}
  
unzip(zipFile)

library(dplyr)

hpow <- filter(mutate(fread("household_power_consumption.txt", na.strings="?", header=TRUE), date2:= as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))), date2 >= as.POSIXct("2007-02-01"), date2 < as.POSIXct("2007-02-03"))

png(filename = "plot2.png", width=480, height=480)

with(hpow,plot(date2, Global_active_power, type="l", ylab="Global Active Power (kilowatts)"))

dev.off()