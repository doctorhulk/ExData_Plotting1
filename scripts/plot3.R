# --------------------------------------------------------------
# Create PLOT#3
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
png("plot3.png",width=480, height=480)

# --------------------------------------------------------------
# Draw the plot

# Create an empty plot
with(household_data_filtered, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))

# Add plots to the empty plot
with(household_data_filtered, lines(DateTime, Sub_metering_1, type="l"))
with(household_data_filtered, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(household_data_filtered, lines(DateTime, Sub_metering_3, type="l", col="blue"))

# Add the legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lty=1)

# --------------------------------------------------------------
# Close the device
dev.off()
# --------------------------------------------------------------