Final_Proj2.html:
	Rscript render.r

.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
