#   Set Up Parameters
readSourceData <- FALSE
fileName <- "data/Part2Plot3.RData"

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
        filter(fips=="24510") %>%
        group_by(type,year) %>%
        summarize(emmissions = sum(Emissions)) %>% 
        rename(SourceType=type) -> plotData
    
    #   Save transformed data for future use
    save(plotData, file = fileName)
} else {
    #   load previously transformed data
    load(fileName)
}

library(ggplot2)

#   Open PNG graphic device
png(filename="./Part 2/plot3.png",width=960,height = 480)

#   Generate plot
g <- ggplot(plotData,aes(x=year,y=emmissions/1000,color=SourceType))
g <- g + geom_line()
g <- g + facet_grid(.~SourceType)
g <- g + ggtitle(expression("Baltimore City Total Emmissions By Source Type in Kilotons of PM"[2.5]))
g <- g + ylab(expression("Emmissions in Kilotons of PM"[2.5]))
g

#   Close graphic device and save PNG file
dev.off()
