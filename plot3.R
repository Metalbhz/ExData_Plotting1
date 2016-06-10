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
    sub_arq [,7] <- as.numeric(as.character(sub_arq[,7]))
    sub_arq [,8] <- as.numeric(as.character(sub_arq[,8]))
    sub_arq [,9] <- as.numeric(as.character(sub_arq[,9]))
    sub_arq <- mutate(sub_arq,Date_Time = parse_date_time(paste(Date,Time),"%y-%m-%d %H:%M:%S"))

}

#changing device to a png file 
png(file="plot3.png",width=480,height=480)

#getting the limits of the graph, y-axis
limY <- c(min(sub_arq[,7], sub_arq[,8], sub_arq[,9]), max(sub_arq[,7], sub_arq[,8], sub_arq[,9]))

#getting the names of arq
narq <- names(arq)

#generating three graphs in one, with par (new = TRUE)
with(sub_arq,plot(Date_Time, Sub_metering_1, type="l",ylab = "Energy sub metering",xlab="",ylim = limY))
par(new = TRUE)
with(sub_arq,plot(Date_Time, Sub_metering_2, type="l",ylab = "Energy sub metering",xlab="",ylim = limY,col="red"))
par(new=TRUE)
with(sub_arq,plot(Date_Time, Sub_metering_3, type="l",ylab = "Energy sub metering",xlab="",ylim = limY,col="blue"))
legend("topright",c(narq[7], narq[8], narq[9]), col = c("black", "red", "blue"),lwd = c(1,2,3))

#getting back to the defautl device
dev.off()