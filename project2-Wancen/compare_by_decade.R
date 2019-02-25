library(tidyverse)
library(dplyr)

suicide_continent= read.csv("suicide_continent.csv")

#select data in 1996-2015
suicide_centries<-filter(suicide_continent,year%in%(c(1996:2015)),!is.na(suicides_no),!is.na(population))

#Get suicide rate within each year among 1996-2015 group by sex and age and create new variable `decade` to tag 2 decades.
by_age<-group_by(suicide_centries,year,sex,age)
suicide_centries_world<-summarise(by_age,number=sum(suicides_no,na.rm=TRUE),population_total=sum(population,na.rm=TRUE))%>% mutate(suicide_rate=number/population_total*100000, decade=if(year %in%c(1996:2005)){return("1996-2005")}else{return("2006-2015")} )

#Get median suicide rate within each decade group by sex and age
by_age_centries<-group_by(suicide_centries_world,decade,sex,age)
suicide_world<-summarise(by_age_centries,suicide_rate=median(suicide_rate))


#Compare suicide rates among sex and age group 
q<-ggplot(suicide_world, aes(x = reorder(age,suicide_rate), y = suicide_rate,fill=sex)) +
  geom_bar(stat="identity",position = "dodge")+
  labs(y="Age-adjusted Suicide Rate",
       x="Age group")+
  theme_light()+
  facet_wrap(~decade,nrow = 2,strip.position = "right")+
  ggtitle('Figure 2:Comparations of suicide rate within each decade')
q + theme(plot.title = element_text( size=10, face="bold.italic"))

ggsave("Histogram.png",width = 6,height=4)