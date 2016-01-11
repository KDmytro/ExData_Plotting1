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

png("plot2.png")

par(mar=c(2.1,4.1,4.1,2.1))
plot(pwr_consump_data$Date_Time, pwr_consump_data$Global_active_power,
     type = "l",
     main = "Global Active Power over time",
     ylab = "Global Active Power (kilowatts)",
     col = "red")

dev.off()
