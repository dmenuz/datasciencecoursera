#Read Data in
setwd("C:\\Users\\Diane\\Documents\\gitRepo\\ExploratoryDataAnalysis_project2")
datfile="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile="dat.zip"
download.file(datfile, destfile)
zipList=unzip(destfile, list=TRUE)
unzip(destfile)
pm= readRDS("summarySCC_PM25.rds")
scc=readRDS("Source_Classification_Code.rds")

#Question 1
#Have total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? 
x=tapply(pm$Emissions, pm$year, sum)

png(filename="plot1.png", width=480, height=480)
barplot(x/1000, xlab="year", ylab="1000 tons PM 2.5", 
    main="PM 2.5 emissions from all sources by year")
dev.off()
