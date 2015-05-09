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
# Plot 4: Display 4 plots:
#   Top Left:     Household global minute-averaged active power (in kilowatt) plot for "1/2/2007" and "2/2/2007"
#   Top Right:    Minute-averaged voltage (in volt)  plot for "1/2/2007" and "2/2/2007"
#   Bottom Left:  Energy sub-metering No. 1,2 & 3 (in watt-hour of active energy) plot for "1/2/2007" and "2/2/2007"
#   Bottom Right: Household global minute-averaged reactive power (in kilowatt) plot for "1/2/2007" and "2/2/2007"
# ---------------------------------------------------------------------------
png("plot4.png",480,480)

par(mfrow = c(2, 2))
with(power1, {
  plot(datetime,Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)") 
  
  plot(datetime,Voltage, type="l",xlab="datetime", ylab="Voltage") 
  
  plot(power1$datetime ,power1$Sub_metering_1, type="l",xlab="", ylab="Energy sub metering")
    lines(power1$datetime ,power1$Sub_metering_2, type="l", col="red")
    lines(power1$datetime ,power1$Sub_metering_3, type="l", col="blue")
    legend("topright", lty=1, col = c("black","blue", "red"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
  
  plot(datetime,Global_reactive_power, type="l",xlab="datetime", ylab="Global Reactive Power") })

dev.off()
