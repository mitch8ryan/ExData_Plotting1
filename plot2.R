# Mitch Ryan Plot 2 R 

# Reading in the file, removing NAs, subsetting our dates
filename <- 'household_power_consumption.txt'
data <- read.csv(filename, sep = ';', colClasses = rep('character', 9))
data[data == '?'] <- NA
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
our_data <- subset(data, Date == '2007-02-01' | Date == '2007-02-02')

# Making the date and time variables into one dateTime object
our_data$posix <- as.POSIXct(strptime(paste(our_data$Date, our_data$Time, sep = " "),
                                      format = "%Y-%m-%d %H:%M:%S"))

# Make Global Active Power Numeric class
our_data$Global_active_power <- as.numeric(our_data$Global_active_power)

# Making the plot
png(filename = 'plot2.png', width = 480, height = 480, units = 'px')
with(our_data, plot(posix, Global_active_power,
                    type = 'l',
                    xlab = '',
                    ylab = 'Global Active Power (kilowatts)'))
dev.off()