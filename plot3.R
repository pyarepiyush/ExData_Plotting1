# ---------------------------------------------------------------------------
# This step does the following:
#     - Reads in the "Individual household electric power consumption Data.txt Set"
#     - Subsets the dataset to keep only the required dates
#     - Creates a datetime field with strptime() 
# ---------------------------------------------------------------------------
setwd("C:/Users/pneupane/Documents/study topics/coursera/exdata/indata")
getwd()

power=read.table("household_power_consumption.txt", 
                 header=TRUE, 
                 sep=";",
                 colClasses=c("character", "character", rep("numeric",7)), 
                 na="?")

# Subset only the dates required
power1=power[power$Date %in% c("1/2/2007","2/2/2007"),]

# Convert into date and time
power1$datetime =     strptime(paste(power1$Date,power1$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# Check column classes
sapply(power1,class)



# ---------------------------------------------------------------------------
#Plot 3: 
# Energy sub-metering No. 1,2 & 3 (in watt-hour of active energy) plot for "1/2/2007" and "2/2/2007"

#   sub_metering_1: corresponds to the kitchen, containing mainly a dishwasher, 
#                   an oven and a microwave (hot plates are not electric but gas powered). 
#   sub_metering_2: corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. 
#   sub_metering_3: corresponds to an electric water-heater and an air-conditioner.
# ---------------------------------------------------------------------------

png("plot3.png",480,480)
plot(power1$datetime ,power1$Sub_metering_1, type="l",xlab="", ylab="Energy sub metering")
lines(power1$datetime ,power1$Sub_metering_2, type="l", col="red")
lines(power1$datetime ,power1$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, col = c("black","blue", "red"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.off()