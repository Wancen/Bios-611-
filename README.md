# Bios-611-
## Project2: 
Outline: Test the association of unemploy,suicide and continient by R and using Makefile to draw the workflow.

Three datasets: suicide.csv continent.csv unemploy.csv

suicide_continent.csv is the dataset joined by suicide.csv and continent.csv. Code was written in Join_12data.R

suicide_2015_world.csv was extracted from suicide_continent.csv when year is 2015

* worldmap.html is a 3D world map generated and saved by 3Dmap.R

* worldmap.rds is all the R information in 3Dmap.R and saved by `saveRDS` function which will be called in Project2.Rmd

* top10_suicide_places.html is the kable generated by top10_suicide_places.R and using `save_kable` function to save it.

* top10_suicide_places.rds is all the R information in top10_suicide_places.R and saved by `saveRDS` function which will be called in Project2.Rmd

Histogram.png is the plot generated and saved by compare_by_decade.R which is used to compare between 1996-2005 and 2006-2015

Unemploy_vs_Suicide.png is the plot generated and saved by unemploy_vs_suicide.R. It displays the association between unemploy and suicide in 2015

* Project2.html is generated by bash command what written in makefile

* project2_workflow.png is the workflow of whole process

If you knit Project2.Rmd in Rstudio, the 3D world map can display when you click `open in browser` at the left top of the automatically generated html file.

## Project3:
outilne: Using Docker to get the separately institutate and their research areas keywords frequency and present it in shiny from thousands of paper

* Build a docker image, install other packages into rocker/tidyverse.

```
FROM rocker/tidyverse

RUN Rscript -e "install.packages(c('tidytext', 'gutenbergr'))"

```
* Run docker: run two process simultinously in main.nf
```
docker run: 
-it 
	--rm 
	-v $(pwd):$(pwd)  
	-w $(pwd)
	rocker/tidyverse
	/bin/bash
```
Finally, we get the summary csv file for all collaborator, filter it and extract top10 keywards into top 10collaborator. Run it in shiny app.

## Homework10
Practicing in model methods. linear regression, train and test data, validation, cluster...
