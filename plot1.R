# Mitch Ryan Plot 1 R file

# Reading in the file, removing NAs, subsetting our dates
filename <- 'household_power_consumption.txt'
data <- read.csv(filename, sep = ';', colClasses = rep('character', 9))
data[data == '?'] <- NA
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
our_data <- subset(data, Date == '2007-02-01' | Date == '2007-02-02')

# Make Global Active Power Numeric class
our_data$Global_active_power <- as.numeric(our_data$Global_active_power)

# Creating our plot 
png(filename = 'plot1.png', width = 480, height = 480, units = 'px')
with(our_data, hist(Global_active_power, col = 'red', 
                    main = 'Global Active Power',
                    breaks = 12,
                    xlab = 'Global Active Power (kilowatts)'))
dev.off()