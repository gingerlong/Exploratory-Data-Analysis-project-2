setwd("/home/user/data_analysis/Exploratory/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BTM <- subset(NEI, fips == "24510")

total_BTM <-tapply(BTM$Emissions/1000, BTM$year, sum)


# transfer total as a vector to be a dataframe
df <- data.frame(template=names(total_BTM), mean=total_BTM)

#plot the answer
png("plot2.png", width = 480, height = 480)

x<-barplot(total_BTM, main = "total PM2.5 emission in Baltimore City", 
           col ="red", ylab = "total PM2.5 emission in kilotons")
text(x, 0.3, round(df$mean,4))
dev.off()

