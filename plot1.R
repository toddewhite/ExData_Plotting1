## Check the data format: Do nothing if .txt file present or unzip .zip file if necessary
if(!file.exists("household_power_consumption.txt")) {
  unzip(zipfile="exdata-data-household_power_consumption.zip")
}

## Read the data from only the 2 days specified
usage <- read.table("household_power_consumption.txt", skip = 66637, nrows = 2880, sep = ";",
           na.strings = "?", col.names = colnames(read.table("household_power_consumption.txt", 
             sep = ";", nrow = 1, header = TRUE)))

##Open PNG device w/file name "plot1.png"
png(filename = "plot1.png")

##Plot histogram of Global active power
hist(usage$Global_active_power, xlab = "Global Active Power (kilowatts)", main = 
       "Global Active Power", col = "red")

##Close PNG device
dev.off()