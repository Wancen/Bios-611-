library(tidyverse)
library(dplyr)
suicide_2015_world=read.csv("suicide_2015_world.csv")
unemploy= read.csv("unemploy.csv")

unemploy_2015=unemploy %>% select(Country.Name,Country.Code,X2015)
#chisq test
Test_2015_world=suicide_2015_world%>% inner_join(unemploy_2015,by=c("alpha.3"="Country.Code")) %>%select(-Country.Name) %>%  filter(!is.na(X2015))
chisq.test(Test_2015_world[,7:8])

#Produce a linear graph of unemployment rate VS Age-adjusted suicide rate
m<-ggplot(data=Test_2015_world, aes(x=suicide_rate,y=X2015,label=Country))+ geom_smooth(method='lm',se=FALSE)+geom_point(color="red")+geom_text(size=2)+
  theme_minimal()+labs(
    title="Figure 3: Unemployment rate VS Age-adjusted Suicide Rate in 2015 \n X-squared=593.82",
    x="Suicide rate(1:100000 people)",
    y="Unemployment percentage"
  )

m + theme(
  plot.title = element_text( size=8, face="bold.italic"))
ggsave("Unemploy_vs_Suicide.png",width = 6,height=4)