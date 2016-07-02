#Read Data in
setwd("C:\\Users\\Diane\\Documents\\gitRepo\\ExploratoryDataAnalysis_project2")
datfile="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile="dat.zip"
download.file(datfile, destfile)
zipList=unzip(destfile, list=TRUE)
unzip(destfile)
pm= readRDS("summarySCC_PM25.rds")
scc=readRDS("Source_Classification_Code.rds")

#Question 3
#Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in 
#emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? 
library(ggplot2)

balt=pm[pm$fips=="24510",]
balt2=aggregate(balt$Emissions, by=list(balt$type, balt$year), sum)
names(balt2)=c("pollutant_type", "year", "value")

png(filename="plot3.png", width=600, height=480)
G=ggplot(balt2, aes(year, value))
G+geom_point(size=4) +geom_smooth(method="lm",se=TRUE)+
  facet_grid(.~pollutant_type)+ylab("Tons of PM2.5 Emissions")+
  ggtitle("Baltimore PM2.5 Emissions by Source")
dev.off()
