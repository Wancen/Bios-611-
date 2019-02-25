library(tidyverse)
library(dplyr)
library(plotly)
suicide_2015_world=read.csv("suicide_2015_world.csv")

l <- list(color = toRGB("#d1d1d1"), width = 0.5)
#Specify map projection and options
g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'orthographic'),
  resolution = '100',
  showcountries = TRUE,
  countrycolor = '#d1d1d1',
  showocean = TRUE,
  oceancolor = '#c9d2e0',
  showlakes = TRUE,
  lakecolor = '#99c0db',
  showrivers = TRUE,
  rivercolor = '#99c0db'
)

p <- plot_geo(suicide_2015_world) %>%
  add_trace(opacity = 0.5, locations = ~alpha.3, colors = 'YlOrRd', marker = list(size=~suicide_rate), type="scattergeo", mode="markers") %>%
  add_trace(z = ~suicide_rate, color = ~suicide_rate, colors = 'YlOrRd',
            text = ~Country, locations = ~alpha.3) %>%
  colorbar(title = 'Age-adjusted Suicide rate') %>%
  layout(title = "Figur 1: World Suicide Rate in 2015 (1 in 100000 people)", geo = g)
p
saveRDS(p, "worldmap.rds")
htmlwidgets::saveWidget(p,"worldmap.html")