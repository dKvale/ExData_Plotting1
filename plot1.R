###########################
#
# plot1.R creates a frequency historgram of the global active power data and saves it as plot1.png
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

# Frequency histogram of Global active power
png("plot1.png", height=480, width=480)
hist(power_data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="Red")
dev.off()
