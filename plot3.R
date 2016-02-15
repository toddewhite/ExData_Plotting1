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

##Open PNG device w/file name "plot3.png"
png(filename = "plot3.png")

##Initialize plot, add line graphs of Sub_metering_1, 2, & 3 by the minute, add legend
plot(usage2$Date_Code, usage2$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(usage2$Date_Code, usage2$Sub_metering_1)
lines(usage2$Date_Code, usage2$Sub_metering_2, col = "red")
lines(usage2$Date_Code, usage2$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1,1), lwd = c(1.5,1.5,1.5), col = c("black", 
      "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Close PNG device
dev.off()