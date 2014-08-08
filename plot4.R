###########################
#
# plot4.R creates a 2x2 grid of plot 2, plot 3, a time series chart of Voltage, and a time
# series of the Global reactive power. The resulting image is saved as plot4.png
#
# The data is online at the UC Irvine Machine Learning Repository,
# and can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# August 8, 2014
###########################

# Load data
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", na.strings="?", stringsAsFactors=FALSE, nrows=1005259)
unlink(temp)

# Filter data to just 2 days: 2007-02-01 and 2007-02-02
power_data <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

# Combine Date and Time columns
power_data$Date_Time <- with(power_data, paste(Date, Time))

# Convert Date format
power_data$Date_Time <- strptime(power_data$Date_Time, "%d/%m/%Y %H:%M:%S")


# Open graphics device
png("plot4.png", height=480, width=480)

# Set plotting grid to 2x2
par(mfrow=c(2,2))

# Line chart of Global Active Power
plot(power_data$Date_Time, power_data$Global_active_power, type='l', xlab="", ylab="Global Active Power")

# Line chart of Voltage
plot(power_data$Date_Time, power_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Layered line chart of Sub-metering
plot(power_data$Date_Time, power_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power_data$Date_Time, power_data$Sub_metering_2, col="red")
lines(power_data$Date_Time, power_data$Sub_metering_3, col="blue")
legend("topright", bty="n", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

# Line chart of Global Reactive Power
plot(power_data$Date_Time, power_data$Global_reactive_power, type='l', ylab="Global_reactive_power", xlab="datetime")

# Close graphics
dev.off()
