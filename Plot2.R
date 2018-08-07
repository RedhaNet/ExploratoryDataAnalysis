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

globalActivePower <- as.numeric(wantedData$Global_active_power)

png('plot2.png', width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off() 