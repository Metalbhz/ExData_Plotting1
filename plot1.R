#loading packages in order to use many commads of them
library(lubridate)
library(dplyr)

#verifying if is necessary load household file into R
if (!exists("arq")) {

#Loading file into R
    arq <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

}

#verifying if exists subset of file
if (!exists("sub_arq")) {

#recovering only oservations where Date is 
    sub_arq <- filter(arq, Date > "2007-01-31" & Date < "2007-02-03")

#Converting variable Date into class Date
    sub_arq [,1] <- as.Date(parse_date_time(sub_arq[,1],c('dmy')))

#Convertin Global Active Power in numeric valeu
    sub_arq [,3] <- as.numeric(as.character(sub_arq[,3]))
}

#changing device to a png file 
png(file="plot1.png",width=480,height=480)

#producing the histogram chart 
hist(sub_arq$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#getting back to the defautl device
dev.off()