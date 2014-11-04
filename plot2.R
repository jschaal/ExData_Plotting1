#   plot2.R
#
#   Create second assignment plot


##  Load Power Subset data previously created by a common  utility scipt called ReadPowerData.R
##  Please see the script ReadPowerData.R included in this repository
load("data/subPowerData.RData")

# open PNG graphic device
png(filename="plot2.png",width=480,height = 480)

# generate plot
plot(subPowerData$Time,subPowerData$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# Save PNG graphic file and close Graphic Device
dev.off()
