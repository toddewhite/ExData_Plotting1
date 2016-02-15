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

##Open PNG device w/file name "plot2.png"
png(filename = "plot2.png")

##Plot line graph of Global active power by the minute
plot(usage2$Date_Code, usage2$Global_active_power, xlab = "",
     ylab = "Global Active Power (kilowatts)", type = "l")

##Close PNG device
dev.off()