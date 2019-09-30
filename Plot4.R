library("data.table")

##Read Data File & Identify Nulls
PowerData <- data.table::fread(input = "PowerData.txt", na.strings = "?")

##Combine Date/Time & Filter
PowerData[, DTC := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
PowerData <- PowerData[(DTC >= "2007-02-01") & (DTC < "2007-02-03")]

##Plotting 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

##Sub-Ploting 1
plot(x = PowerData[, DTC], y = PowerData[, Global_active_power], type = "l", 
     xlab = "Time of Day from 1-2 Feb 2007", ylab = "Global Active Power (kilowatts)")

##Sub-Ploting 2
plot(PowerData[, DTC],PowerData[, Voltage], type = "l", 
     xlab = "Time of Day from 1-2 Feb 2007", ylab = "Voltage")

##Sub-Ploting 3
plot(PowerData[, DTC], PowerData[, Sub_metering_1], type = "l", 
     xlab = "Time of Day from 1-2 Feb 2007", ylab = "Energy Sub-Metering")
lines(PowerData[, DTC], PowerData[, Sub_metering_2], col = "Red")
lines(PowerData[, DTC], PowerData[, Sub_metering_3], col = "Blue")
legend("topright", col = c("Black","Red","Blue"), lty = 1, lwd = 2,
       legend = c("Sub-Metering 1  ","Sub-Metering 2  ", "Sub-Metering 3"))

##Sub-Ploting 4
plot(PowerData[, DTC], PowerData[,Global_reactive_power], type = "l", 
     xlab = "Time of Day from 1-2 Feb 2007", ylab="Global Reactive Power")

dev.off()
