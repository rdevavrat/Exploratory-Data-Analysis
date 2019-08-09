# Exploratory-Data-Analysis
Replicate CDC Flu data analysis using twitter data in R and Python


### Problem Definition:


The task is to replicate the US flu heatmap provided on (www.cdc.gov/flu/weekly/.com) by mining flu related tweets from Twitter using Twitter API.
The heat map is to be plotted using geolocations of the mined tweets.


#### Pre-requisites

Programming Language : R, Python

Packages used: Rtweet, ggmap, ggplot

### Analysis

Around 1,000,000 tweets were mined using different keywords like "flu", "#flu", "influenza", etc. 
For tweets without locations, the location is added using "geocode" from Google's API. 
The US heatmap generated using the tweets isnt as close as the one on the CDC website.

The results can be seen on the ShinyApp deployed.
