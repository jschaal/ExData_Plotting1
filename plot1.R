#   plot1.R
#
#   Create first assignment plot

##  Load Power Subset data previously created by a common  utility scipt called ReadPowerData.R
##  Please see the script ReadPowerData.R included in this repository
load("data/subPowerData.RData")  

# open PNG graphic device
png(filename="plot1.png",width=480,height = 480)

# generate plot
hist(subPowerData$Global_active_power,main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",col="red")

# Save PNG graphic file and close Graphic Device
dev.off()
