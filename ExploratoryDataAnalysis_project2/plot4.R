#Read Data in
setwd("C:\\Users\\Diane\\Documents\\gitRepo\\ExploratoryDataAnalysis_project2")
datfile="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile="dat.zip"
download.file(datfile, destfile)
zipList=unzip(destfile, list=TRUE)
unzip(destfile)
pm= readRDS("summarySCC_PM25.rds")
scc=readRDS("Source_Classification_Code.rds")

#Question 4
#Across the United States, how have emissions from 
#coal combustion-related sources changed from 1999-2008?

#extract out codes related to coal combustion
coalvals=grep("Coal", scc$EI.Sector)
x=scc$EI.Sector[coalvals]
table(factor(x))
coalscc=scc$SCC[x]
#extract out values from pm for coal scc
coal=pm[pm$SCC %in% coalscc,]
coal2=aggregate(coal$Emissions, list(coal$year), sum)
colnames(coal2)=c("year", "emissions")
#create plot

png(filename="plot4.png", width=480, height=480)
G=ggplot(coal2, aes(year, emissions))
G+geom_point(size=4) +geom_smooth(method="lm",se=TRUE)+
  ylab("Tons of PM2.5 Emissions")+ggtitle("Coal PM2.5 Emissions by Year")
dev.off()
