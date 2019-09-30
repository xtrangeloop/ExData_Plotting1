library("data.table")

##Read Data File & Identify Nulls
PowerData <- data.table::fread(input = "PowerData.txt", na.strings = "?")

##Convert Dates & Filter
PowerData[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
PowerData <- PowerData[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

##Convert Power Info to Numbers for Easy Reading
PowerData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

##Plotting 1
png("plot1.png", width = 480, height = 480)
hist(PowerData[,Global_active_power], col = "red", main = "Global Active Power", xlab = "Globabl Active Power (kilowatts)", ylab = "Frequency")
dev.off()
