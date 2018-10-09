# This function reads data from household_power_consumption.txt
# and, using a subset of power consumption data from 2/1/07 to 2/2/07,
# it creates a line chart showing global active power by day in kilowatts

plot2 <- function() {
  
  # subset the data to get the time period that we want
  data <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, sep = ";", header = TRUE)
  data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
  data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")  
  
  # reformat Global active power to numeric and create datetime field dt
  dt <- paste(data$Date, data$Time)
  data$dt <- as.POSIXct(dt)
  data$Global_active_power <- as.numeric(data$Global_active_power)
  
  # create plot
  png("plot2.png", width = 480, height = 480)
  with(data, {plot(Global_active_power ~ dt, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  })
  dev.off()
}