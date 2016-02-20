URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temporaryfile <- tempfile()
download.file(URL , temporaryfile)
unzip(temporaryfile )

data<- read.table("./household_power_consumption.txt", na.strings="?", sep=";", header = T)


data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
data <- na.omit(data)
data <- data[data$Date == as.Date("01/02/2007", format = "%d/%m/%Y") | data$Date == as.Date("02/02/2007", format = "%d/%m/%Y"),]

png(filename = "plot1.png", bg = "white")
hist(data$Global_active_power , col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()