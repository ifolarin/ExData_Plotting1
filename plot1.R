
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="household_power_consumption.zip")
unzip("household_power_consumption.zip")

test <- read.csv("household_power_consumption.txt", nrows=10, na.strings="?", sep=";", header=TRUE)
library(dplyr)
dt <- tbl_df(test)

as.Date(strptime(paste(test$Date, test$Time), "%d/%m/%Y %H:%M:%S"))

hpow <- filter(mutate(fread("household_power_consumption.txt", na.strings="?", header=TRUE), date2:= as.Date(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))), date2 >= as.Date("2007-02-01"), date2 <= as.Date("2007-02-02"))
png(filename = "plot1.png", width=480, height=480)
hist(hpow$Global_active_power, main="Global Active Power", xlab="Global Active Power (killowatts)", col="red")
dev.off()