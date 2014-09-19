setwd("/home/user/data_analysis/Exploratory/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset the cities
BTM <- subset(NEI, fips == "24510")
LA <- subset(NEI, fips ==  "06037")

#subset the motor vehicle sources 
motor_BTM <- subset(BTM, type == "ON-ROAD")
motor_BTM <- motor_BTM[,c(4,6)]

motor_LA <- subset(LA, type == "ON-ROAD")
motor_LA <- motor_LA[,c(4,6)]


#aggdata for BTM
aggdata <-aggregate(motor_BTM, by=list(year = motor_BTM$year),
                    FUN=sum, na.rm=TRUE)
aggdata.BTM<- aggdata[, c(1, 2)]

aggdata.BTM<-transform(aggdata.BTM, year = factor(year))

#aggdata for LA
aggdata <-aggregate(motor_LA, by=list(year = motor_LA$year),
                    FUN=sum, na.rm=TRUE)
aggdata.LA <- aggdata[, c(1, 2)]

aggdata.LA<-transform(aggdata.LA, year = factor(year))

aggdata.LA$City <- c("LA")
aggdata.BTM$City <- c("BTM")


both <- rbind(aggdata.LA,aggdata.BTM)


library(ggplot2)

png("plot6.png", width = 480, height = 480)

g <- ggplot(both,aes(x=year, y=Emissions,color=City, group = city))
g <- g + geom_point(size=4)
g <- g + geom_line()
g <- g + xlab("Years")
g <- g + ylab(expression("Total "* PM[2.5]~" Emissions in [Tons]")
g <- g + ggtitle(expression("Total "* PM[2.5]~" Emissions of Motor Vehicle Sources in BTM and LA"))
g + geom_text(aes(label=both$Emissions, size=1, hjust=0.5, vjust=2))
                   
dev.off()