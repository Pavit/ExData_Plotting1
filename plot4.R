# This function reads data from household_power_consumption.txt
# and, using a subset of power consumption data from 2/1/07 to 2/2/07,
# it creates a grid of four charts, showing Global active power by day,
# Global active power by day split up by sub_metering, Voltage by day,
# Global reactive power by day.

plot4 <- function() {
  
  # subset the data to get the time period that we want
  data <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, sep = ";", header = TRUE)
  data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
  data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")  
  
  # reformat Global active and reactive power to numeric and create datetime field dt
  dt <- paste(data$Date, data$Time)
  data$dt <- as.POSIXct(dt)
  data$Global_active_power <- as.numeric(data$Global_active_power)
  data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
  # create plot
  png("plot4.png", width = 480, height = 480)
  par(mfrow = c(2,2))
  with(data, {plot(Global_active_power ~ dt, type = "l", ylab = "Global Active Power", xlab = "")})
  with(data, {plot(Voltage ~ dt, type = "l", ylab = "Voltage", xlab = "datetime")})
  with(data, {plot(Sub_metering_1 ~ dt, type = "l", ylab = "Energy Sub Metering",  xlab = "", col = "Black")})
  lines(data$Sub_metering_2 ~ data$dt, col = "Red")
  lines(data$Sub_metering_3 ~ data$dt, col = "Blue")
  legend("topright", lty = 1, lwd = 3, col = c("Black","Red","Blue") ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  with(data, {plot(Global_reactive_power ~ dt, type = "l", ylab = "Global_reactive_power", xlab = "datetime")})
  
  
  dev.off()
}