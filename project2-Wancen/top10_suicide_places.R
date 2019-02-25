library(knitr)
library(dplyr)

suicide_2015_world=read.csv("suicide_2015_world.csv")
as_tibble(suicide_2015_world)

#List top 10 most vulnerable demographic within world 

a<-kable(suicide_2015_world[order(-suicide_2015_world$suicide_rate),][1:10,c(1,2,7)],caption="Top 10 highest suicide rate countries")

saveRDS(a, "top10_suicide_places.rds")