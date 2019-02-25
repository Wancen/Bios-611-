suicide.csv:
	curl -o suicide.csv https://raw.githubusercontent.com/datasci611/project2-Wancen/master/suicide.csv?token=AoxalR-RDrwmC1O4KBdMgJIeF9h-dGbQks5b12SVwA%3D%3D

continent.csv:
	curl -o continent.csv https://raw.githubusercontent.com/datasci611/project2-Wancen/master/continent.csv?token=AoxalbPZrhnqNte4wdX5ktGZef9rGXLTks5b12VdwA%3D%3D

unemploy.csv:
	curl -o unemploy.csv https://raw.githubusercontent.com/datasci611/project2-Wancen/master/unemploy.csv?token=Aoxalev-8jhPEvssXF_F4ZOAlrC33V20ks5b12UlwA%3D%3D

suicide_continent.csv: suicide.csv continent.csv Join_12data.R
	Rscript Join_12data.R

suicide_2015_world.csv: suicide_continent.csv
	Rscript Suicide_2015_world.R

world_map.html: suicide_2015_world.csv 3Dmap.R
	Rscript 3Dmap.R

top10_suicide_places.rds: suicide_2015_world.csv
	Rscript top10_suicide_places.R

Histogram.png: suicide_continent.csv compare_by_decade.R
	Rscript compare_by_decade.R

Unemploy_vs_Suicide.png: suicide_2015_world.csv unemploy.csv
	Rscript unemploy_vs_suicide.R

Project2.html: Project2.Rmd world_map.html Histogram.png Unemploy_vs_Suicide.png top10_suicide_places.rds
	R -e "rmarkdown::render('Project2.Rmd')"

project2_workflow.png:
	make Project2.html -Bnd | ./makefile2graph/make2graph | dot -Tpng -o project2_workflow.png