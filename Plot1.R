fileURL = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if (!file.exists('power_cons_zip')){
  download.file(fileURL, 'power_cons_zip')
} else {
  if (!file.exists('household_power_consumption.txt')){
    unzip('power_cons_zip')
  }
}

powerData <- read.table('household_power_consumption.txt', sep = ';', header = F)

newColNames <- paste(unlist(as.list(powerData[1,])))

colnames(powerData) <- newColNames

powerData <- powerData[-1,]

powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")

wantedData <- subset(powerData, Date == '2007-02-01' | Date == '2007-02-02')

hist(as.numeric(wantedData$Global_active_power), breaks = 14, xaxt = 'n', col = 'red')
axis(1, at=seq(0, 2880 , 2880/3), labels = seq(0, 6, 2))

