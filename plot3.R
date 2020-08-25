# We first download the data files, if we do not have downloaded yet, 
# and read it to a dataframe. 

# The explanation of the variables can be read at
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

library(sqldf) # For reading just a subset of the file

if (!exists("data")){ 
  if (!file.exists("household_power_consumption.txt")){
    temp <- tempfile()    # Since the file given is a zip, we download it temporarily
    download.file(
      "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
    unzip(temp)
    unlink(temp)
  }
  data <- read.csv.sql("household_power_consumption.txt", sep = ";", header = TRUE,
                       sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
} 

# Code for plot3.png:

png(filename = "figure/plot3.png", width=2500, height=2000, res=100, pointsize = 30)
# We plot one of the curves first:

with(data, plot(Sub_metering_1~Datetime, type = "l", ylab = "Energy sub metering"))

# and add the rest using lines()
with(data, lines(Sub_metering_2~Datetime, col="red"))

with(data, lines(Sub_metering_3~Datetime, col="blue"))

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()