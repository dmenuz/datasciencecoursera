#Read Data in
setwd("C:\\Users\\Diane\\Documents\\gitRepo\\ExploratoryDataAnalysis_project2")
datfile="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile="dat.zip"
download.file(datfile, destfile)
zipList=unzip(destfile, list=TRUE)
unzip(destfile)
pm= readRDS("summarySCC_PM25.rds")
scc=readRDS("Source_Classification_Code.rds")

#Question 6
#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). Which city has seen greater changes 
#over time in motor vehicle emissions?

#Extract out motor vehicle source data
mobile=scc[scc$SCC.Level.One=="Mobile Sources",]
mobile2=mobile[mobile$SCC.Level.Two %in% c("Highway Vehicles - Diesel", "Highway Vehicles - Gasoline"),]
sccs=mobile2$SCC
#Extract out data from Baltimore and from motor vehicles
cities=pm[pm$fips %in% c("24510", "06037") & pm$SCC %in% sccs,]
cities$city=ifelse(cities$fips=="24510", "Baltimore", "Los Angeles")

#aggregate data
cityagg=aggregate(cities$Emissions, list(cities$year, cities$city), sum)
colnames(cityagg)=c("year", "county","emissions")
#create plot
png(filename="plot6.png", width=480, height=480)
G=ggplot(cityagg, aes(year, emissions))
G+geom_point(size=4) +geom_smooth(method="lm",se=TRUE)+
  facet_grid(.~county)+
  ylab("Tons of PM2.5 Emissions")+ggtitle("Motor Vehicle PM2.5 Emissions")
dev.off()

