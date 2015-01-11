# --------------------------------------------------------------
# Create PLOT#4
# --------------------------------------------------------------
# Load the dataset

# Set locale to display abbreviated weekdays in English. 
Sys.setlocale("LC_TIME", "English") 

# Download the file, if doesn't exist
if(!file.exists("household_power_consumption.txt")) {
	fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileURL, method="curl", destfile="household_power_consumption.zip")
	unzip("household_power_consumption.zip")
}

# Load data
household_data<-read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?",stringsAsFactors=F, comment.char="")

# Filter the data
household_data_filtered<-subset(household_data, Date %in% c("1/2/2007","2/2/2007"))

# Free some memory
rm(household_data)

# Convert date/time strings to appropriate data types
household_data_filtered$DateTime<-strptime(paste(household_data_filtered$Date,household_data_filtered$Time, sep=" "),format="%d/%m/%Y %H:%M:%S")

# --------------------------------------------------------------
# Open the PNG Grapthics Device
png("plot4.png",width=480, height=480)

# --------------------------------------------------------------
# Draw the plot

# Divide the canvas into 4 subsections, organization row-wise
par(mfrow=c(2,2))

# Draw the first sub-plot
with(household_data_filtered, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power", xlab=""))

# Draw the second sub-plot
with(household_data_filtered, plot(DateTime, Voltage, type="l", xlab="datetime"))

# Draw the third sub-plot
with(household_data_filtered,{
plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(DateTime, Sub_metering_1, type="l")
lines(DateTime, Sub_metering_2, type="l", col="red")
lines(DateTime, Sub_metering_3, type="l", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lty=1, bty="n")
})

# Draw the fourth sub-plot
with(household_data_filtered, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))

# --------------------------------------------------------------
# Close the device
dev.off()
# --------------------------------------------------------------