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

# Subset the vehicles NEI data by each city's fip and add city name.
baltimoreVehiclesNEI<-subset(vehiclesNEI, fips == "24510")
baltimoreVehiclesNEI$city <- "Baltimore City"

LAVehiclesNEI <- subset(vehiclesNEI, fips=="06037")
LAVehiclesNEI$city <- "Los Angeles County"

# Combine the two subsets 
bothNEI <- rbind(baltimoreVehiclesNEI,LAVehiclesNEI)

#generate graph
png("plot6.png", width=480, height=480)


library(ggplot2)

ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(ggp)

dev.off()
