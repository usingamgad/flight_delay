##fligt delay data:
##https://www.transtats.bts.gov/HomeDrillChart.asp

setwd('/Users/fh186009/Documents/training/Bootcamp/airline project/data')

flight<-read.csv('2008.csv',nrows=1000)


flight<-cbind(flight[,c(1:24)],
               sapply(flight[,c(25:29)],function(x){ifelse(is.na(x),0,x)},USE.NAMES = TRUE))

#neg delays?
min_delay<-sapply(flight[,c(25:29)],min)

test<-flight[,c('DayOfWeek','ArrTime','LateAircraftDelay')]
lm<-lm(data=test,LateAircraftDelay~DayOfWeek+ArrTime)



predict(lm,data.frame(DayOfWeek=1,ArrTime=2338))