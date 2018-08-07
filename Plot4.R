fileURL = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if (!file.exists('power_cons_zip')){
  download.file(fileURL, 'power_cons_zip')
} else {
  if (!file.exists('household_power_consumption.txt')){
    unzip('power_cons_zip')
  }
}

powerData <- read.table('household_power_consumption.txt', sep = ';', header = T, stringsAsFactors=FALSE)

wantedData <- subset(powerData, Date %in% c('1/2/2007','2/2/2007'))

datetime <- strptime(paste(wantedData$Date, wantedData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

subMetering1 <- as.numeric(wantedData$Sub_metering_1)
subMetering2 <- as.numeric(wantedData$Sub_metering_2)
subMetering3 <- as.numeric(wantedData$Sub_metering_3)

globalActivePower <- as.numeric(wantedData$Global_active_power)
globalReactivePower <- as.numeric(wantedData$Global_reactive_power)
voltage <- as.numeric(wantedData$Voltage)

png('plot4.png', width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power")

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")

lines(datetime, subMetering2, type="l", col="red")

lines(datetime, subMetering3, type="l", col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
