if (!file.exists("Exploratory_Data_Analysis")){
  dir.create("Exploratory_Data_Analysis")
}

setwd("C:\\Users\\mpmar\\Desktop\\data scientists_courses\\Exploratory_Data_Analysis")


##load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Gather the  data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset data by Baltimore vehicles
baltimoreVehiclesNEI<-subset(vehiclesNEI, fips == "24510")

#generate graph
png("plot5.png", width=480, height=480)

library(ggplot2)

ggp <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)

dev.off()
