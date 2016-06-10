#loading packages in order to use many commads of them
library(lubridate)
library(dplyr)

#verifying if is necessary load household file into R
if (!exists("arq")) {

#loading file into R
  arq <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

}

#verifying if exists subset of file
if (!exists("sub_arq")) {

#converting variable Date into class Date
    arq [,1] <- as.Date(parse_date_time(arq[,1],c('dmy')))

#recovering only oservations where Date is 
    sub_arq <- filter(arq, Date > "2007-01-31" & Date < "2007-02-03")

#convertin Global Active Power in numeric valeu
    sub_arq [,3] <- as.numeric(as.character(sub_arq[,3]))
    sub_arq [,4] <- as.numeric(as.character(sub_arq[,4]))
    sub_arq [,5] <- as.numeric(as.character(sub_arq[,5]))
    sub_arq [,7] <- as.numeric(as.character(sub_arq[,7]))
    sub_arq [,8] <- as.numeric(as.character(sub_arq[,8]))
    sub_arq [,9] <- as.numeric(as.character(sub_arq[,9]))
  
#creating a variable Date_Time
    sub_arq <- mutate(sub_arq,Date_Time = parse_date_time(paste(Date,Time),"%y-%m-%d %H:%M:%S"))
    
}

#changing device to a png file 
png(file="plot4.png",width=480,height=480)

#getting the limits of the graph, y-axis
limY <- c(min(sub_arq[,7], sub_arq[,8], sub_arq[,9]), max(sub_arq[,7], sub_arq[,8], sub_arq[,9]))

#getting the names of arq
narq <- names(arq)

#setting par in order to work with four graphs at the same pannel 
par (mfrow=c(2,2))

#generating graph 1
with(sub_arq,plot(Date_Time, Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab=""))

#generating graph 2
with(sub_arq,plot(Date_Time, Voltage, type="l",ylab = "Voltage",xlab="datetime"))

#generating graph 3
with(sub_arq,plot(Date_Time, Sub_metering_1, type="l",ylab = "Energy sub metering",xlab="",ylim = limY))
with(sub_arq,lines(Date_Time, Sub_metering_2, type="l", col="red"))
with(sub_arq,lines(Date_Time, Sub_metering_3, type="l", col="blue"))
legend("topright",c(narq[7], narq[8], narq[9]), col = c("black", "red", "blue"),lwd = c(1,2,3))

#generating graph 4
with(sub_arq,plot(Date_Time, Global_reactive_power, type="l",xlab="datetime"))

#getting back to the defautl device
dev.off()
