# Load the data and generate plot3.png


# Download and read the data using copied link
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
Electricity_data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = TRUE)
unlink(temp)

# Convert Date and Time variables to Date/Time classes
Electricity_data$Date <- as.Date(Electricity_data$Date, format = "%d/%m/%Y")
Electricity_data$Time <- strptime(paste(Electricity_data$Date, Electricity_data$Time, sep=" "),
                                  format = "%Y-%m-%d %H:%M:%S")


# Subset the data set so that it only includes the data from 2007-02-01 and 2007-02-02
Electricity_data <- subset(Electricity_data, Date==as.Date("2007/02/01") | Date==as.Date("2007/02/02"))

# Convert all columns exept Time and Date into numeric values
Electricity_data <- mutate_at(Electricity_data, vars(-c(Date, Time)), as.numeric)

# Open png connection
png(filename="plot3.png")

# Generate contents for plot3.png
with(Electricity_data, plot(Time, Sub_metering_1,
                            xlab = "",
                            ylab = "Energy sub metering",
                            type = 'n'))
# Add lines one by one
with(Electricity_data, lines(Time, Sub_metering_1))
with(Electricity_data, lines(Time, Sub_metering_2, col="red"))
with(Electricity_data, lines(Time, Sub_metering_3, col="blue"))

# Add legend
legend("topright", lty=1, col=c("black","red","blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the graphics device
dev.off()
