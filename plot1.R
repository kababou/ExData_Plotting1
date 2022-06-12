## Read data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep = ";", header = TRUE)
unlink(temp)

## Subset data based on desired dates

data$Date <- as.Date(data$Date,"%d/%m/%Y")
data <- data[data$Date >= "2007/02/01" & data$Date <= "2007/02/02",]

## Create a PosixLT value and add it to the data

data <- tidyr::unite(data, DateTime, Date, Time, sep = ' ', na.rm = TRUE, remove = FALSE) 

## Coerce Datetime and Numeric Data to the right class

data$DateTime <- with(data, as.POSIXct(DateTime, format = "%Y-%m-%d %H:%M:%OS"))
data[,4:10] <- sapply(data[,4:10],as.numeric)

## GRAPH 1 

png(file="./plot1.png", width=480, height=480)
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red", xlim = c(0,6))
dev.off()
