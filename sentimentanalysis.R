#libraries for nlp in R should be installed 
library(tidytext)
library(syuzhet)
library(dplyr)

#read your csv file in the variable 
moviereview<-read.csv("Movie_reviews.csv")

head(moviereview)

moviereview$Sentiment<-get_sentiment(moviereview$reviews,method="syuzhet")

print(moviereview)


#Sentiment score analysis using the points 
moviereview<-moviereview%>%
  mutate(SentimentCategory=case_when(
    Sentiment>0~"Positive",
    Sentiment<0~"Negative",
    TRUE~"Neutral"
  ))

print(moviereview)
View(SentimentCategory)

write.csv(moviereview,"reviews_with_movies.csv",row.names = FALSE)

#plot 
library(ggplot2)
ggplot(moviereview,aes(y=Sentiment , x=rating, fill = SentimentCategory ))+geom_bar(stat = "identity")+labs(x="Rating",y="sentiment score")+theme_light()