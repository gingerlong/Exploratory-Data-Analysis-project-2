setwd("/home/user/data_analysis/Exploratory/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BTM <- subset(NEI, fips == "24510")

#My decision is based  on the equivalence of "motor vehicle" and "road vehicle"  from wiki-paper http://en.wikipedia.org/wiki/Motor_vehicle.  
#Therefore I've selected "On-Road"  in EI.Sector

motor_BTM <- subset(BTM, type == "ON-ROAD")

motor_BTM <-tapply(motor_BTM$Emissions, motor_BTM$year, sum)


# transfer total as a vector to be a dataframe
df <- data.frame(template=names(motor_BTM), mean=motor_BTM)

#plot
png("plot5.png", width = 480, height = 480)

barplot(motor_BTM, main = "Emissions change from motor vehicle sources in Baltimore City", 
        col= "red", ylab = "Emissions from motor vehicle sources in tons")
text(x, 20, round(df$mean,1))

dev.off()