zipFile <- "../household_power_consumption.zip"

if(!file.exists(zipFile)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="household_power_consumption.zip")
}
  
unzip(zipFile)

library(dplyr)

hpow <- filter(mutate(fread("household_power_consumption.txt", na.strings="?", header=TRUE), date2:= as.Date(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))), date2 >= as.Date("2007-02-01"), date2 <= as.Date("2007-02-02"))

png(filename = "plot1.png", width=480, height=480)

hist(hpow$Global_active_power, main="Global Active Power", xlab="Global Active Power (killowatts)", col="red")

dev.off()