#   Set Up Parameters
readSourceData <- TRUE
fileName <- "data/Part2Plot6.RData"

#   Read and craete data if readSourceData is true
if (readSourceData) {
    
    #   Read Raw Data    
    NEI <- readRDS("data/summarySCC_PM25.rds")
    SCC <- readRDS("data/Source_Classification_Code.rds")
    
    library(dplyr)
    
    #   Find categories that have gasoline powered motor vehicles
    grpList <- grepl("Vehicle",SCC$SCC.Level.Two)
    vehicleSources <- SCC[grpList,]
    
    #   Convert data.frame to a dplyr table.
    tableSCC <- tbl_df(vehicleSources)
    
    #   Convert data.frame to a dplyr table.
    table <- tbl_df(NEI)
    
    #   Filter, Transform and Summarize Raw Data        
    table %>% 
        #   Perform inner join with SCC Vehicle subset
        inner_join(tableSCC)  %>%
        #   Filter for Baltimore City, MD
        filter((fips=="06037")|(fips=="24510")) %>%
        group_by(fips,year) %>%
        summarize(emmissions = sum(Emissions)) %>%
        mutate(Area=ifelse(fips=="06037","Los Angeles County","Baltimore City")) -> plotData
    
    
    #   Save transformed data for future use
    save(plotData, file = fileName)
} else {
    #   load previously transformed data
    load(fileName)
}

library(ggplot2)

#   Open PNG graphic device
png(filename="./Part 2/plot6.png",width=640,height = 480)

#   Generate plot
g <- ggplot(plotData,aes(x=year,y=emmissions,color=Area))
g <- g + geom_line()
g <- g + ggtitle(expression("Total Emmissions from Motor Vehicles in Tons of PM"[2.5]))
g <- g + ylab(expression("Emmissions in Tons of PM"[2.5]))
g

#   Close graphic device and save PNG file
dev.off()
