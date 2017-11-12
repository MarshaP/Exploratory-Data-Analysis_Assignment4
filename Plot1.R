if (!file.exists("Exploratory_Data_Analysis")){
  dir.create("Exploratory_Data_Analysis")
}

setwd("C:\\Users\\mpmar\\Desktop\\data scientists_courses\\Exploratory_Data_Analysis")


##load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate: sum the total emissions by year
TotEmission <- aggregate(Emissions ~ year,NEI, sum)

#generate graph
png("plot1.png", width=480, height=480)

barplot(
  (TotEmission$Emissions)/10^6,
  names.arg=TotEmission$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)

dev.off()
