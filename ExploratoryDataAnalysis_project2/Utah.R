#Read Data in
setwd("C:\\Users\\Diane\\Documents\\gitRepo\\ExploratoryDataAnalysis_project2")
datfile="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile="dat.zip"
download.file(datfile, destfile)
zipList=unzip(destfile, list=TRUE)
unzip(destfile)
pm= readRDS("summarySCC_PM25.rds")
scc=readRDS("Source_Classification_Code.rds")

fips=read.csv("utahFIPS.csv", header=FALSE)


fips=c("49005", "49011", "49035", "49049", "49057")
cos=c("Cache", "Davis", "Salt Lake", "Utah", "Wayne")
dat=pm[pm$fips %in% fips,]
lookup=data.frame(fips, cos)
dat2=merge(dat, lookup, by="fips")

#aggregate data
coagg=aggregate(dat2$Emissions, list(dat2$year, dat2$cos, dat2$type), sum)
colnames(coagg)=c("year", "county","type","emissions")
#create plot
G=ggplot(coagg, aes(year, emissions))
G+geom_point(size=3) +geom_smooth(method="lm",se=TRUE)+
  facet_grid(type~county)

##Salt Lake county data only

