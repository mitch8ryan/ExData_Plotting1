# Mitch Ryan Plot 3 R 

# Reading in the file, removing NAs, subsetting our dates
filename <- 'household_power_consumption.txt'
data <- read.csv(filename, sep = ';', colClasses = rep('character', 9))
data[data == '?'] <- NA
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
our_data <- subset(data, Date == '2007-02-01' | Date == '2007-02-02')

# Making the date and time variables into one dateTime object
our_data$posix <- as.POSIXct(strptime(paste(our_data$Date, our_data$Time, sep = " "),
                                      format = "%Y-%m-%d %H:%M:%S"))

# Make all 3 sub metering vaiables numeric class
our_data$Sub_metering_1 <- as.numeric(our_data$Sub_metering_1)
our_data$Sub_metering_2 <- as.numeric(our_data$Sub_metering_2)
our_data$Sub_metering_3 <- as.numeric(our_data$Sub_metering_3)

# Making the plot
png(filename = 'plot3.png', width = 480, height = 480, units = 'px')
with(our_data, plot(posix, Sub_metering_1,
                    type = 'l',
                    xlab = '',
                    ylab = 'Energy Sub Metering'))
with(our_data, points(posix, type = 'l', Sub_metering_2, col = 'red'))
with(our_data, points(posix, type = 'l', Sub_metering_3, col = 'blue'))
legend('topright', col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)
dev.off()