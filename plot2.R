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
#Plot 2: household global minute-averaged active power (in kilowatt) plot for "1/2/2007" and "2/2/2007"
# ---------------------------------------------------------------------------

png("plot2.png",480,480)
plot(power1$datetime,label=T,power1$Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
