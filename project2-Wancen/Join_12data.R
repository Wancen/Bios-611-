library(tidyverse)
library(dplyr)
library(stringdist)
suicide= read.csv("suicide.csv")
suicide = as_tibble(suicide)
continent= read.csv("continent.csv", header=TRUE)
continent = as_tibble(continent) 
unemploy= read.csv("unemploy.csv")
unemploy = as_tibble(unemploy) 

#Choose variables we want to use
continent_sorted<-select(continent,name,region,alpha.2,alpha.3)

source('find_bestname_function.R')

#Find best match country name stored in 'best_names' for all country names in 'suicide' dataset  to better join together
all_countries=as.character(unique(suicide$country))
best_names=vector(mode="character",length(all_countries))
for(j in seq_along(all_countries)){
  c = all_countries[j]
  bn=find_best_name(c)
  best_names[j]=as.character(bn)
}
country_matches=tibble(
  in_country= all_countries,
  Country=best_names)
country_matches

#Join two dataset with the key 'country'
suicide2=suicide %>% left_join(country_matches,by=c("country"="in_country")) %>% select(-country)
suicide_continent=suicide2 %>% left_join(continent_sorted,by=c("Country"="name")) 
write.csv(suicide_continent,"suicide_continent.csv")