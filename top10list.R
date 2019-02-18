library(tidyverse)
library(dplyr)
library(tidytext)
args = commandArgs(trailingOnly = TRUE)
Summary<-read.csv(args[1],encoding = "UTF-8",stringsAsFactors = FALSE)

#args = commandArgs(trailingOnly = TRUE)
#Summary<-read.csv(args[1])


#Count the collaboration times for each collaborator
Ordersum<-Summary %>%
  group_by(collaborator) %>% 
  tally() %>% 
  arrange(desc(n))

#Get the top 10 institutation and join with Summary to get information of title and abstract
top10<-head(Ordersum,10)
top10summary<-as_tibble(inner_join(top10,Summary,by="collaborator"))

#First, get the abundant, differentiating words for each abstract 
#By doing so, overall key words are more comprehensive and representative after merge for collaborator
mostword <- top10summary %>%
  unnest_tokens(word, abstract) %>%
  anti_join(stop_words,by="word") 

mostword<-mostword[- grep("patients|clinical|patient", mostword$word),]
mostwords<-mostword %>% 
  group_by(collaborator, n,title, word) %>%
  summarise(nword = n()) %>%
  mutate(rank = row_number(-nword)) %>%
  filter(nword>5 & rank<=3) %>% #We assume that key words of each abstract should be mentioned more than 5 times
  arrange(collaborator,title, desc(nword)) %>% 
  group_by(collaborator,n) %>% 
  mutate(rank = row_number(-nword)) %>% 
  filter(rank<=15) %>% 
  arrange(collaborator,rank)

#Then we try to get the overall most frequncy words for each institution
#mostwords2<-aggregate(nword~collaborator+word,data = mostwords,sum) %>% arrange(collaborator,desc(nword))

#By observation, we delete row with word "patient" because those are not differentiating words


write.csv(mostwords,file("top10collaborator.csv"),row.names=FALSE)





