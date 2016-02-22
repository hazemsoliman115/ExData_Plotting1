## get the data
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temporaryfile <- tempfile()
download.file(URL , temporaryfile)
unzip(temporaryfile )

data<- read.table("./household_power_consumption.txt", na.strings="?", sep=";", header = T)

## convert date and time
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

## remove na values
data <- na.omit(data)

## select right dates
data <- data[data$Date == as.Date("01/02/2007", format = "%d/%m/%Y") | data$Date == as.Date("02/02/2007", format = "%d/%m/%Y"),]

png(filename = "plot4.png", bg = "white")
## create the 4 subplots
par(mfrow=c(2,2))
## plot the first time series
plot(data$Global_active_power,type="l", xaxt = "n" , ylab = "Global Active Power",xlab = "", main = "")
axis(1, at = c(0,length(data$Global_active_power)/2,length(data$Global_active_power)), labels = c("Thu","Fri","Sat"))

## plot the second time series
plot(data$Voltage ,type="l", xaxt = "n" , ylab = "Voltage",xlab = "datetime", main = "")
axis(1, at = c(0,length(data$Global_active_power)/2,length(data$Global_active_power)), labels = c("Thu","Fri","Sat"))

## plot the third
plot(data$Sub_metering_1,type="n", xaxt = "n" , ylab = "Energy sub metering",xlab = "", main = "")
axis(1, at = c(0,length(data$Sub_metering_1)/2,length(data$Sub_metering_1)), labels = c("Thu","Fri","Sat"))
lines(data$Sub_metering_1, col = "black")
lines(data$Sub_metering_2, col = "red")
lines(data$Sub_metering_3, col = "blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_1","Sub_metering_1"),lty=c(1,1),col=c("black","red","blue"),bty = "n" )

## plot the fourth
plot(data$Global_reactive_power,type="l", xaxt = "n" , ylab = "Global_reactive_power",xlab = "", main = "")
axis(1, at = c(0,length(data$Global_active_power)/2,length(data$Global_active_power)), labels = c("Thu","Fri","Sat"))

dev.off()