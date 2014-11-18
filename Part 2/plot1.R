#   Set Up Parameters
readSourceData <- TRUE
fileName <- "data/Part2Plot1.RData"

#   Read and craete data if readSourceData is true
if (readSourceData) {
    
    #   Read Raw Data    
    NEI <- readRDS("data/summarySCC_PM25.rds")
    SCC <- readRDS("data/Source_Classification_Code.rds")
    
    library(dplyr)
    
    #   Convert data.frame to a dplyr table.
    #   Filter, Transform and Summarize Raw Data     
    table <- tbl_df(NEI)
    table %>% 
        group_by(year) %>%
        summarize(emmissions = sum(Emissions)) -> plotData
    
    #   Save transformed data for future use
    save(plotData, file = fileName)
} else {
    #   load previously transformed data
    load(fileName)
}

#   Open PNG graphic device
png(filename="./Part 2/plot1.png",width=480,height = 480)

#   Generate plot
plot(plotData$year,plotData$emmissions/1000,type="l",
     xlab="Year",
     ylab=expression('United States Total Emmissions in KiloTons of PM'[2.5]))

#   Close graphic device and save PNG file
dev.off()