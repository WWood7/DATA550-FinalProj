IMAGE_NAME=wwu77/final

.PHONY: install docker-build report-macos report-windows clean

Final_Proj2.html: Final_Proj2.rmd output/table1.rds output/plot.png
	Rscript render.r

output/table1.rds: code/tableone.r data/lung_cancer_dataset.csv
	Rscript code/tableone.r

output/plot.png: code/plot.r data/lung_cancer_dataset.csv
	Rscript code/plot.r

install:
	Rscript -e "renv::restore(prompt = FALSE)"

docker-build:
	docker build -t $(IMAGE_NAME) .

report-macos: 
	mkdir -p report
	docker run -v "$$(pwd)/report":/project/final_report $(IMAGE_NAME)


report-windows:
	mkdir -p report
	docker run -v "/$$(pwd)/report":/project/final_report $(IMAGE_NAME)

clean:
	rm -f Final_Proj2.html output/table1.rds output/plot.png
	rm -rf report
