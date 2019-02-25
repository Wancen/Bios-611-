library(tidyverse)
library(dplyr)

suicide_continent= read.csv("suicide_continent.csv")
#create a new variable `suicide_rate`used by WHO.to calculate suicide rate whose definition is age-standardized rates(per 100k people)
suicide_2015<-filter(suicide_continent,year==2015,!is.na(suicides_no),!is.na(population))
by_country_2015<-group_by(suicide_2015,region,Country,sex,alpha.3)
suicide_2015_world<-summarise(by_country_2015,number=sum(suicides_no),population_total=sum(population)) %>% 
  mutate(suicide_rate=number/population_total*100000) 

write.csv(suicide_2015_world,"suicide_2015_world.csv",row.names = FALSE)