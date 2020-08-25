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

# Code for plot1.png:

png(filename = "plot1.png", res = 125)
with(data, hist(Global_active_power, col= 'red', 
                main = "Global active power",
                xlab = "Global active power (kilowats)"))
dev.off()

# Code for plot2.png:

data["Datetime"] = with(data, paste(Date,Time))
data$Datetime = as.POSIXct(data$Datetime, format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png", width=1440, height=1200, res=100, pointsize = 30)
with(data, plot(Global_active_power ~ Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()