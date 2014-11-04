#   plot4.R
#
#   Create third assignment plot


##  Load Power Subset data previously created by a common  utility scipt called ReadPowerData.R
##  Please see the script ReadPowerData.R included in this repository
load("data/subPowerData.RData")

# open PNG graphic device
png(filename="plot4.png",width=480,height = 480)

# Adjust graphic device to plot 4 graphs on same canvas side by side
# and set margins to show axis labels that accomodates the 480 x 480 plot
par(mfcol = c(2, 2), mar = c(4, 5, 3, 1))

# Plot top left graph (previous plot 2 with slight change in y axis label)
plot(subPowerData$Time,subPowerData$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

# Plot bottom left graph (previous plot 3) with no box outline in legend
#determine common range for 3 line that will be consolidated on a single plot
yrange=range(c(subPowerData$Sub_metering_1,subPowerData$Sub_metering_2,subPowerData$Sub_metering_3))

# generate main plot
plot(subPowerData$Time,subPowerData$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering",ylim=yrange, col="black")
# add additional line plots
lines(subPowerData$Time,subPowerData$Sub_metering_2,type = "l", col="red")
lines(subPowerData$Time,subPowerData$Sub_metering_3,type = "l", col="blue")

# add common legend
legend("topright",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,bty = "n")

# Create top right plot (new plot type)
plot(subPowerData$Time,subPowerData$Voltage,
     type="l",
     ylab="Voltage",
     xlab="datetime")

# Create bottom right plot (new plot type)
plot(subPowerData$Time,subPowerData$Global_reactive_power,
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime")

# Save PNG graphic file and close Graphic Device
dev.off()
