#Clean title
args = commandArgs(trailingOnly = TRUE)

a<-read.csv(args[1],header = FALSE)
b<-unique(a)
b<-b[2:nrow(b),]
colnames(b)<-c("collaborator","title","abstract")

write.csv(b,file("Summary.csv"),row.names=FALSE)