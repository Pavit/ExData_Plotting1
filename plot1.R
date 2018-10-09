# This function reads data from household_power_consumption.txt
# and, using a subset of power consumption data from 2/1/07 to 2/2/07,
# it creates a histogram showing global active power in kilowatts

plot1 <- function() {
  
  # subset the data to get the time period that we want
  data <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, sep = ";", header = TRUE)
  data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
  data <- subset(data, Date == "2007-02-01" | Date =="2007-02-02")
  
  # reformat Global active power to numeric
  data$Global_active_power <- as.numeric(data$Global_active_power)

  # create plot
  png("plot1.png", width = 480, height = 480)
  hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
  dev.off()
}