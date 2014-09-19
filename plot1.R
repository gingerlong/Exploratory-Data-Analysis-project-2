setwd("/home/user/data_analysis/Exploratory/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total <-tapply(NEI$Emissions/1000, NEI$year, sum)

# transfer total as a vector to be a dataframe
df <- data.frame(template=names(total),mean=total)

## Plotting the answer
png("plot1.png", width = 480, height = 480)

x<-barplot(total,  col="red", main = "total PM2.5 emission decreased in US", 
           ylab = "total PM2.5 emission in kilotons")

text(x, 1000, round(df$mean))
dev.off()

## Answer: Yes, total emissions from PM2.5 have decreased in the United States from 1999 to 2008.


## Answer: Yes, total emissions from PM2.5 have decreased in the United States from 1999 to 2008.