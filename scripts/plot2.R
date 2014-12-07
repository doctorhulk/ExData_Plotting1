# --------------------------------------------------------------
# Create PLOT#2
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
png("plot2.png",width=480, height=480)

# --------------------------------------------------------------
# Draw the plot
with(household_data_filtered, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

# --------------------------------------------------------------
# Close the device
dev.off()
# --------------------------------------------------------------