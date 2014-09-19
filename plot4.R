setwd("/home/user/data_analysis/Exploratory/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sccsubset <- subset(SCC, grepl("coal|Coal", EI.Sector, ignore.case=TRUE), select=c(SCC, EI.Sector))

coalSCC <- sccsubset$SCC

coalNEI <- NEI[NEI$SCC %in% coalSCC,]

coaltotal <-tapply(coalNEI$Emissions/1000, coalNEI$year, sum)

# transfer total as a vector to be a dataframe
df <- data.frame(template=names(coaltotal), mean=coaltotal)

png("plot4.png", width = 480, height = 480)

a<- barplot(coaltotal, main = "coal related PM2.5 emission changes in US", 
        col = "red",
        ylab = "coal related PM2.5 emission in kilotons")
text(x, 50, round(df$mean,1))
dev.off()