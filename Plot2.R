library("data.table")

##Read Data & Identify Nulls
PowerData <- data.table::fread(input = "PowerData.txt", na.strings = "?")

##Convert Dates & Filter //Attempts to speed the Filtering
##PowerData[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
##PowerData[, Time := lapply(.SD, as.Time, "%H:%M:%S"), .SDcols = c("Time")]
##PowerData <- PowerData[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
##PowerData[, DTC := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
##PowerData[, DTC := c(Date, Time)]

##Combine Date/Time & Filter (DTC = Date Time Combined)
PowerData[, DTC := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
PowerData <- PowerData[(DTC >= "2007-02-01") & (DTC < "2007-02-03")]

##Plotting 2
png("plot2.png", width = 480, height = 480)
plot(x = PowerData[, DTC], y = PowerData[, Global_active_power], type = "l", 
     xlab = "Time of Day from 1-2 Feb 2007", ylab = "Global Active Power (kilowatts)")
dev.off()