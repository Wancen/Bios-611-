library(stringr)
library(tidyverse)
args = commandArgs(trailingOnly = TRUE)
abs0<-readLines(args[1])
#abs0<-readLines("D:/Study/611/homework-Wancen/project3/p2_abstracts/abs133.txt")

#Fixed errors of when there is no space between two words and remove numbers
abs0=gsub('[0-9]+', '', abs0)
abs0s=gsub("([a-z])([A-Z])", "\\1 \\2", abs0[4])
abs0s=gsub("(of)([a-z])|([a-z])(of)", "\\1 \\2", abs0s)

#Obtain each author's information seperated by '(' or ';'
author<-unlist(strsplit(abs0s, '[\\(\\;]'))
#Obtain different levels of collaborator information for each author seperated by ',' or '.'
authors<-strsplit(author,'[\\,\\.)]')

#Select collaborator information with key words by ordering after observasing tons of .txt author information 
order1<-c("University|Inc|NIH|RTI")
order2<-c("College|Institute|association")
order3<-c("school|center|centre|hospital|clinic|lab")
order4<-c("Program|branch|Division|group")

infor=list()
for (i in 1:length(authors)){
  if(sum(str_detect(authors[[i]],regex(order1,ignore_case=TRUE))>0)){
    infor[[i]]<-str_subset(authors[[i]],regex(order1,ignore_case=TRUE))
  }else if (sum(str_detect(authors[[i]],regex(order2,ignore_case=TRUE))>0)){
    infor[[i]]<-str_subset(authors[[i]],regex(order2,ignore_case=TRUE))
  }else if (sum(str_detect(authors[[i]],regex(order3,ignore_case=TRUE))>0)){
    infor[[i]]<-str_subset(authors[[i]],regex(order3,ignore_case=TRUE))
  }else if (sum(str_detect(authors[[i]],regex(order4,ignore_case=TRUE))>0)){
    infor[[i]]<-str_subset(authors[[i]],regex(order4,ignore_case=TRUE))
  }else {infor[[i]]<-NA}
} 

#Exclude collaborator named University of North Carolina, gillings or Lineberger
infors<-infor[!grepl("University of North Carolina|Gillings|Lineberger",infor)&!is.na(infor)]
infors<-data.frame(collaborator = unlist(infors)) 
d=nrow(infors)
#Add tile and abstract information to outputcsv
title=data.frame(rep(abs0[2],d))
abstract=data.frame(rep(abs0[5],d))
Abs0<-data.frame(infors,title,abstract)

write.csv(Abs0,file("out.csv"),row.names=FALSE)

