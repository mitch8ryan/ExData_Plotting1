# Mitch Ryan Plot 4 R 

# Reading in the file, removing NAs, subsetting our dates
filename <- 'household_power_consumption.txt'
data <- read.csv(filename, sep = ';', colClasses = rep('character', 9))
data[data == '?'] <- NA
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
our_data <- subset(data, Date == '2007-02-01' | Date == '2007-02-02')

# Making the date and time variables into one dateTime object
our_data$posix <- as.POSIXct(strptime(paste(our_data$Date, our_data$Time, sep = " "),
                                      format = "%Y-%m-%d %H:%M:%S"))

# Make Global Active Power, Voltage, Global Reactive Power Numeric class
our_data$Global_active_power <- as.numeric(our_data$Global_active_power)
our_data$Voltage <- as.numeric(our_data$Voltage)
our_data$Global_reactive_power <- as.numeric(our_data$Global_reactive_power)

# Make all 3 sub metering vaiables numeric class
our_data$Sub_metering_1 <- as.numeric(our_data$Sub_metering_1)
our_data$Sub_metering_2 <- as.numeric(our_data$Sub_metering_2)
our_data$Sub_metering_3 <- as.numeric(our_data$Sub_metering_3)

# Making the plot
png(filename = 'plot4.png', width = 480, height = 480, units = 'px')
par(mfrow = c(2, 2))

with(our_data, plot(posix, Global_active_power,
                    type = 'l',
                    xlab = '',
                    ylab = 'Global Active Power'))

with(our_data, plot(posix, Voltage,
                    type = 'l',
                    xlab = 'datetime',
                    ylab = 'Voltage'))

with(our_data, plot(posix, Sub_metering_1,
                    type = 'l',
                    xlab = '',
                    ylab = 'Enery Sub Metering'))
with(our_data, points(posix, type = 'l', Sub_metering_2, col = 'red'))
with(our_data, points(posix, type = 'l', Sub_metering_3, col = 'blue'))
legend('topright', col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)

with(our_data, plot(posix, Global_reactive_power,
                    type = 'l',
                    xlab = 'datetime',
                    ylab = 'Global_reactive_power'))
dev.off()