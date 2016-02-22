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

png(filename = "plot2.png", bg = "white")
## plot the time series
plot(data$Global_active_power,type="l", xaxt = "n" , ylab = "Global Active Power (kilowatts)",xlab = "", main = "")
## adjust the x axis values
axis(1, at = c(0,length(data$Global_active_power)/2,length(data$Global_active_power)), labels = c("Thu","Fri","Sat"))
dev.off()