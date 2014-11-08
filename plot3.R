#   plot3.R
#
#   Create third assignment plot


#   Execute R Script common to all plots used to create Power Data Subset
#   Please see the script ReadPowerData.R included in this repository
#   The script will create a data.frame called SubPowerData which is the input data to this plot 
source("ReadPowerData.R")

#   Optionally and more efficiently, Load Power Subset data previously created by ReadPowerData.R
#   load("data/subPowerData.RData")  

#   open PNG graphic device
png(filename="plot3.png",width=480,height = 480)

#   determine common range for 3 line that will be consolidated on a single plot
yrange=range(c(subPowerData$Sub_metering_1,subPowerData$Sub_metering_2,subPowerData$Sub_metering_3))

#   generate main plot
#   subPowerData is the data.frame created by  R script ReadPowerData.R
plot(subPowerData$Time,subPowerData$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering",ylim=yrange, col="black")

#   add additional line plots
lines(subPowerData$Time,subPowerData$Sub_metering_2,type = "l", col="red")
lines(subPowerData$Time,subPowerData$Sub_metering_3,type = "l", col="blue")

#   add common legend
legend("topright",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1)

#   Save PNG graphic file and close Graphic Device
dev.off()
