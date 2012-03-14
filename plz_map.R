# 
# Author: Arne
###############################################################################

library(ggplot2)
library(zipcode)
#library(maps)

setwd("C:\\Users\\Arne\\Dropbox\\R\\ordinates")
setwd("~/My Dropbox/R/ordinates")

plz <- read.delim("Data/PLZ.tab")

plz$plz_2 <- clean.zipcodes(plz$plz)
plz$region <- (substr(plz$plz_2, 1, 1))

p <- ggplot(data= plz) + geom_point(aes(x = lon, y = lat))
p


p <- ggplot(data= plz) + geom_point(aes(x = lon, y = lat, colour = region), alpha = 1, shape = 19, size = 2)
p <- p + theme_bw() + labs(x = NULL, y = NULL) + scale_colour_brewer(palette = "RdYlGn", name = "PLZ")
p <- p + scale_x_continuous(breaks = NA) + scale_y_continuous(breaks = NA)
p 



## Deutschlandkarte
# nach http://jeffreybreen.wordpress.com/2010/10/22/incremental-improvements-to-nightlights-mapping-thanks-to-r-bloggers/
# vorher hier verwendet: http://ryouready.wordpress.com/2009/11/16/infomaps-using-r-visualizing-german-unemployment-rates-by-color-on-a-map/
library(raster)

de_map <- getData('GADM', country="DE", level=1)
de_map_2 <- fortify(de_map, region = "NAME_1")
gpclibPermit()
de_map_2 <- fortify(de_map, region = "NAME_1")

# testweise kleinere Map
de_map_3 <- de_map_2[seq(1,97610, 10),]

p2 <- ggplot(data= plz) + geom_point(aes(x = lon, y = lat, colour = region), alpha = 0.8, shape = 19, size = 2)
p2 <- p2 + geom_path(data = de_map_2, aes(x = long, y = lat, group = group), colour = "grey20")
p2 <- p2 + theme_bw() + labs(x = NULL, y = NULL) + scale_colour_brewer(palette = "RdYlGn", name = "PLZ")
p2 <- p2 + scale_x_continuous(breaks = NA) + scale_y_continuous(breaks = NA)
p2





