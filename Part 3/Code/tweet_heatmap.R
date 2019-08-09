rm(list = ls())

library(rtweet)
library(revgeo)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(twitteR)
library(devtools)
library(dplyr)
library(maptools)
library(urbnmapr)
library(viridis)
devtools::install_github("dkahle/ggmap")

# Read the Geocodes for query = 'Headache'
locations <- read.csv("Influenza_locations.csv")
locations$X <- NULL

# Eliminate all the tweets with NULL Geocodes
locations <- na.omit(locations)

# Function to map statenames from geocodes
geoloc_to_states <- function(Final_Locations) 
{
  areas <- map('state', fill=TRUE, col="transparent", plot=FALSE)
  id <- sapply(strsplit(areas$names, ":"), function(x) x[1])
  areas_space <- map2SpatialPolygons(areas, IDs = id, proj4string=CRS("+proj=longlat +datum=WGS84"))
  
  pointsSP <- SpatialPoints(Final_Locations, proj4string=CRS("+proj=longlat +datum=WGS84"))
  
  i <- over(pointsSP, areas_space)
  
  stateNames <- sapply(areas_space@polygons, function(x) x@ID)
  stateNames[i]
}


# Run the above function to retrieve the state name for each tweet based on their geo locations
region <- c(1:nrow(locations))
for(i in 1:nrow(locations))
{
  region[i] <- geoloc_to_states(locations[i,])
}


# Store the corresponding state for each tweet 
data_to_plot <- cbind(locations,region)

# Eliminate all the tweets with NULL states
data_to_plot <- na.omit(data_to_plot)

# Count the number of tweets per region
count_tweets <- summary(as.factor(data_to_plot$region))
state_namesss <- sort(unique(data_to_plot$region))

# Store the count of tweets for wach state
cnt <- c()
for(i in 1:length(count_tweets))
{
  cnt[i] <- count_tweets[[i]]
}



states$region <- tolower(states$state_name)

SS <- unique(states$region)
ss <- data.frame(unique(states$region))
colnames(ss) <- c("region")

data_to_plot <- data.frame(state_namesss,cnt)
colnames(data_to_plot) <- c("region","level")



final_data_to_plot <- merge(data_to_plot,ss,by = "region",all=TRUE)

x11()
final_data_to_plot %>% 
  left_join(states, by = "region") %>% 
  ggplot(mapping = aes(long, lat, group = group, fill = level)) +
  geom_polygon(color = "#ffffff", size = .25) +
  scale_fill_gradientn(colours=c("cyan","yellow","red","orange","green"), 
                       label=c("minimal","low","medium","high","very high"), breaks=c(0,20,40,80,200)) 
