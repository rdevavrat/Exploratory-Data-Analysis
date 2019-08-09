rm(list = ls())

library(rtweet)
library(revgeo)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(twitteR)
library(devtools)
library(maptools)
library(urbnmapr)
library(viridis)
library(dplyr)


#setting up the authentication using secret keys and tokens
token <- create_token(
  app = "ML Model",
  consumer_key = "oRIjXvYi1qRAus5u2pC5jJFWx",
  consumer_secret = "Z2LmQnNbikrT3xOaqK7tGfIiJaszywFstRvXaTPTs1wgMFuM8n",
  access_token = "429752368-74kgIRzCGa7BrkmhHMOVs09yUVVK8Ch9lrZrB9dE",
  access_secret = "H5qYfc4u2aMIRrUmHHcKLZtKD3SoVnYT4Bby0BQxSJhHy")
identical(token, get_token())


#mining tweets using different keywords
tweets <- search_tweets("flu OR #flu OR FLU OR #FLU OR #Influenza OR Influenza OR #INFLUENZA OR INFLUENZA OR sneeze OR cold", 
                        n = 100000, lang="en", type="recent",
                        geocode = lookup_coords("usa", apikey = "AIzaSyC9H_AJJtINiyw9L5g2PgSdF7tOc8kXXaA"), 
                        include_rts = FALSE, retryonratelimit=TRUE)
tweets$geo_coords <- vapply(tweets$geo_coords, paste, collapse = ", ", character(1L))
tweets$created_at <- vapply(tweets$created_at, paste, collapse = ", ", character(1L))
write.csv(tweets[,c("text", "created_at", "screen_name", "geo_coords")], file="mined_twitter_data.csv", row.names=TRUE)
tweets1 <- search_tweets("viral+infection OR congestion OR body+aches OR fever", 
                         n = 100000, lang="en", type="recent",
                         geocode = lookup_coords("usa", apikey = "AIzaSyC9H_AJJtINiyw9L5g2PgSdF7tOc8kXXaA"), 
                         include_rts = FALSE, retryonratelimit=TRUE)
#pre processing data to save it in the csv file.
tweets1$geo_coords <- vapply(tweets1$geo_coords, paste, collapse = ", ", character(1L))
tweets1$created_at <- vapply(tweets1$created_at, paste, collapse = ", ", character(1L))
write.csv(tweets1[,c("text", "created_at", "screen_name", "geo_coords")], file="mined_twitter_data_2.csv", row.names=TRUE)
          location <- c()
          for(i in 1:length(tweets$geo_coords)){
            if(!grepl("NA", tweets$geo_coords[i])){
              location <- rbind(location, tweets$geo_coords[i])
            }
          }
          for(i in 1:length(tweets1$geo_coords)){
            if(!grepl("NA", tweets1$geo_coords[i])){
              location <- rbind(location, tweets1$geo_coords[i])
            }
          }
          splitLoc <- c()
          for(i in 1:length(location)){
            splitLoc[i] <- strsplit(location[i], ", ")
          }
          finalLoc <- data.frame("long"=numeric(), "lat"=numeric())
          for(i in 1:length(splitLoc)){
            if(grepl("United States of America", revgeo(longitude = as.numeric(splitLoc[[i]][2]), latitude = as.numeric(splitLoc[[i]][1])))){
              new1 <- list("long"=as.numeric(splitLoc[[i]][2]), "lat"=as.numeric(splitLoc[[i]][1]))
              finalLoc <- rbind(finalLoc, new1)
            }   
          }
          write.csv(finalLoc, file="Influenza_locations.csv")
#mined twitter data and saved in csv