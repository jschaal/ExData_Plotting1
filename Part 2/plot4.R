#   Set Up Parameters
readSourceData <- TRUE
fileName <- "data/Part2Plot4.RData"

#   Read and craete data if readSourceData is true
if (readSourceData) {
    
    #   Read Raw Data    
    NEI <- readRDS("data/summarySCC_PM25.rds")
    SCC <- readRDS("data/Source_Classification_Code.rds")
    
    library(dplyr)
    #   Find only those coal combustion related classifications
    #   Create list of SCC entries that have (1) Coal or (2) Comb in Short Name
    pattern <- c("Coal","Comb")
    grpList <- lapply(pattern,grepl,SCC$Short.Name)
    
    #   Find Short Names with both Coal and Comb
    coalClasses <- Reduce(`&`,grpList)
    coalSources <- SCC[coalClasses,]
    
    #   Convert data.frame to a dplyr table.
    tableCoal <- tbl_df(coalSources)
    
    #   Convert data.frame to a dplyr table.
    table <- tbl_df(NEI)
    
    #   Filter, Transform and Summarize Raw Data        
    table %>% 
        #   Perform inner join with SCC Coal subset
        inner_join(tableCoal)  %>%
        group_by(year) %>%
        summarize(emmissions = sum(Emissions)) -> plotData
    
    #   Save transformed data for future use
    save(plotData, file = fileName)
} else {
    #   load previously transformed data
    load(fileName)
}

library(ggplot2)

#   Open PNG graphic device
png(filename="./Part 2/plot4.png",width=960,height = 480)

#   Generate plot
g <- ggplot(plotData,aes(x=year,y=emmissions/1000))
g <- g + geom_line()
g <- g + ggtitle(expression("United States Total Emmissions Of Coal Combustion in Kilotons of PM"[2.5]))
g <- g + ylab(expression("Emmissions in Kilotons of PM"[2.5]))
g

#   Close graphic device and save PNG file
dev.off()
