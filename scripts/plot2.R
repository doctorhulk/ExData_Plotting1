# --------------------------------------------------------------
# Create PLOT#2
# --------------------------------------------------------------
# Load the dataset

# Download the file
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, method="curl", destfile="household_power_consumption.zip")

# Load it
unzip("household_power_consumption.zip")
household_data<-read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?",stringsAsFactors=F, comment.char="")

# Filter the data
household_data_filtered<-household_data[household_data$Date %in% c("1/2/2007","2/2/2007"),]

# Free some memory
rm(household_data)

# Convert date/time strings to appropriate data types
household_data_filtered$Date<-as.Date(household_data_filtered$Date,format="%d/%m/%Y")
household_data_filtered$Time<-strptime(paste(household_data_filtered$Date,household_data_filtered$Time, sep=" "),format="%Y-%m-%d %H:%M:%S")	


# --------------------------------------------------------------
# Open the PNG Grapthics Device
png("plot2.png",width=480, height=480)

# --------------------------------------------------------------
# Draw the plot
with(household_data_filtered, plot(Time, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

# --------------------------------------------------------------
# Close the device
dev.off()
# --------------------------------------------------------------