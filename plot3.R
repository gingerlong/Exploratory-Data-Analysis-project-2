
## Setting the Current Working Directory
setwd("/home/user/data_analysis/Exploratory/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subset the data from BTM city
BTM <- subset(NEI, fips == "24510")

library(ggplot2)


png("plot3.png", width = 480, height = 480)

a <- ggplot(BTM, aes(factor(year), Emissions))
a <- a+ geom_bar(stat="identity") 
a + facet_wrap( ~type)

dev.off()