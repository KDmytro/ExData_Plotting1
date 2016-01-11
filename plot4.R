colNames <- names(read.table("./data/household_power_consumption.txt", nrow=1, header=TRUE, sep=";"))

# nskip <- grep("^1/2/2007", readLines("./data/household_power_consumption.txt"))[1]-1
# readrows <- (grep("3/2/2007", readLines("./data/household_power_consumption.txt"))[1] -1) - nskip

nskip <- 66637
readrows <- 2880

pwr_consump_data <- read.table("./data/household_power_consumption.txt",
                               sep = ";",
                               na.strings = "?",
                               header = FALSE,
                               col.names = colNames,
                               skip = nskip,
                               nrow = readrows)

pwr_consump_data$Date <- as.Date(pwr_consump_data$Date, "%d/%m/%Y")

pwr_consump_data$Date_Time <- strptime(paste(pwr_consump_data$Date,pwr_consump_data$Time), "%Y-%m-%d %H:%M:%S")

png("plot4.png")

par(mfrow = c(2,2))

par(mar=c(3,4,1,2))

# PLOT #1
plot(pwr_consump_data$Date_Time, pwr_consump_data$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)")

# PLOT #2
plot(pwr_consump_data$Date_Time, pwr_consump_data$Voltage,
     type = "l",
     ylab = "Voltage")

# PLOT #3
plot(pwr_consump_data$Date_Time, pwr_consump_data$Sub_metering_1,
     type = "n",
     ylab = "Energy sub metering"
     )

lines(pwr_consump_data$Date_Time, pwr_consump_data$Sub_metering_1, col = "black")
lines(pwr_consump_data$Date_Time, pwr_consump_data$Sub_metering_2, col = "red")
lines(pwr_consump_data$Date_Time, pwr_consump_data$Sub_metering_3, col = "blue")

legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)

# PLOT #4

plot(pwr_consump_data$Date_Time, pwr_consump_data$Global_reactive_power,
     type = "l",
     ylab = "Global reactive power")

dev.off()