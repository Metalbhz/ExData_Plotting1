#loading packages in order to use many commads of them
library(lubridate)
library(dplyr)

#verifying if is necessary load household file into R
if (!exists("arq")) {

#loading file into R
    arq <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

}

#Verifying if exists subset of file
if (!exists("sub_arq")) {

#Converting variable Date into class Date
    arq [,1] <- as.Date(parse_date_time(arq[,1],c('dmy')))

#recovering only oservations where Date is 
    sub_arq <- filter(arq, Date > "2007-01-31" & Date < "2007-02-03")

#Convertin Global Active Power in numeric valeu
    sub_arq [,3] <- as.numeric(as.character(sub_arq[,3]))
    sub_arq <- mutate(sub_arq,Date_Time = parse_date_time(paste(Date,Time),"%y-%m-%d %H:%M:%S"))

}

#changing device to a png file 
png(file="plot2.png",width=480,height=480)

#producing the line chart 
with(sub_arq,plot(Date_Time, Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab=""))

#getting back to the defautl device
dev.off()