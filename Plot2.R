if (!file.exists("Exploratory_Data_Analysis")){
  dir.create("Exploratory_Data_Analysis")
}

setwd("C:\\Users\\mpmar\\Desktop\\data scientists_courses\\Exploratory_Data_Analysis")



##load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data by Baltimore's fip.
NEIdataBaltimore<-subset(NEI, fips == "24510")

# Aggregate: sum the emissions in Baltimore data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, NEIdataBaltimore,sum)

#generate graph
png("plot2.png", width=480, height=480)

barplot(
  aggTotalsBaltimore$Emissions,
  names.arg=aggTotalsBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From all Baltimore City Sources"
)

dev.off()
