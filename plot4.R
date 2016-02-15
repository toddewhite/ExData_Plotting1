## Check the data format: Do nothing if .txt file present or unzip .zip file if necessary
if(!file.exists("household_power_consumption.txt")) {
  unzip(zipfile="exdata-data-household_power_consumption.zip")
}

## Read the data from only the 2 days specified
usage <- read.table("household_power_consumption.txt", skip = 66637, nrows = 2880, sep = ";",
           na.strings = "?", col.names = colnames(read.table("household_power_consumption.txt", 
             sep = ";", nrow = 1, header = TRUE)))

##Combine date and time and convert to Date-Time class.
date_time_char <- paste(usage$Date, usage$Time)
date_time <- strptime(date_time_char, "%d/%m/%Y\ %H:%M:%S")

##Add this variable to the data.frame (w/new name)
usage2 <- cbind(usage, Date_Code = date_time)

##Open PNG device w/file name "plot4.png"
png(filename = "plot4.png")

##Set the plot area to hold 4 plots built down columns 
par(mfcol = c(2,2))

##Plot line graph of Global active power by the minute
plot(usage2$Date_Code, usage2$Global_active_power, xlab = "",
     ylab = "Global Active Power", type = "l")

##Initialize plot, add line graphs of Sub_metering_1, 2, & 3 by the minute, add legend
plot(usage2$Date_Code, usage2$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(usage2$Date_Code, usage2$Sub_metering_1)
lines(usage2$Date_Code, usage2$Sub_metering_2, col = "red")
lines(usage2$Date_Code, usage2$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1,1), bty = "n", col = c("black", "red", "blue"), 
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Plot line graph of Voltage by the minute
plot(usage2$Date_Code, usage2$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

##Plot line graph of Global reactive power by the minute
plot(usage2$Date_Code, usage2$Global_reactive_power, xlab = "datetime", 
     ylab = "Global_reactive_power", type = "l")

##Close PNG device
dev.off()