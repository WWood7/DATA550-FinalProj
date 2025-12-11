Final_Proj2.html: Final_Proj2.rmd output/table1.rds output/plot.png
	Rscript render.r

output/table1.rds: code/tableone.r data/lung_cancer_dataset.csv
	Rscript code/tableone.r

output/plot.png: code/plot.r data/lung_cancer_dataset.csv
	Rscript code/plot.r

.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
