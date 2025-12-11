FROM rocker/r-ubuntu

# System deps for rendering (pandoc) and cleanup to keep image small
RUN apt-get update && \
    apt-get install -y --no-install-recommends pandoc && \
    rm -rf /var/lib/apt/lists/*



RUN mkdir /project
WORKDIR /project


RUN mkdir -p renv
COPY renv.lock .
COPY .Rprofile .
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json


RUN Rscript -e "install.packages('renv', repos = 'https://cloud.r-project.org')" && \
    Rscript -e "renv::restore(prompt = FALSE)"


COPY . .


RUN mkdir -p output final_report
CMD make && mv Final_Proj2.html final_report/
