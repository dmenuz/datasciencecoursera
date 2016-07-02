#Read Data in
setwd("C:\\Users\\Diane\\Documents\\gitRepo\\ExploratoryDataAnalysis_project2")
datfile="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile="dat.zip"
download.file(datfile, destfile)
zipList=unzip(destfile, list=TRUE)
unzip(destfile)
pm= readRDS("summarySCC_PM25.rds")
scc=readRDS("Source_Classification_Code.rds")

#Question 5
#How have emissions from motor vehicle sources changed from 
#1999-2008 in Baltimore City?

#Extract out motor vehicle source data
mobile=scc[scc$SCC.Level.One=="Mobile Sources",]
mobile2=mobile[mobile$SCC.Level.Two %in% c("Highway Vehicles - Diesel", "Highway Vehicles - Gasoline"),]
sccs=mobile2$SCC
#Extract out data from Baltimore and from motor vehicles
balt=pm[pm$fips=="24510" & pm$SCC %in% sccs,]

#aggregate data
balt2=aggregate(balt$Emissions, list(balt$year), sum)
colnames(balt2)=c("year", "emissions")
#create plot
png(filename="plot5.png", width=480, height=480)
G=ggplot(balt2, aes(year, emissions))
G+geom_point(size=4) +geom_smooth(method="lm",se=TRUE)+
  ylab("Tons of PM2.5 Emissions")+ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore by Year")
dev.off()

