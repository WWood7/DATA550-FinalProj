# DATA550-FinalProj

## Description
The final report contains a brief description of the dataset used, a table of descriptive statistics, and a plot showing predicted lung cancer probability.

## Installation
To restore the package environment for this project, run:
```bash
make install
```

## How to generate
In a terminal, set the working directory to the project root directory, use the command `make Final_Proj2.html`.

## Code
- Main narrative and knitting: `Final_Proj2.rmd`
- Table script: `code/tableone.r` (writes `output/table1.rds`)
- Plot script: `code/plot.r` (writes `output/plot.png`)

## Docker
### Docker Image
You can build the image locally with `make docker-build`, or pull it from Docker Hub:
- `docker pull wwu77/final`
Docker Hub link: https://hub.docker.com/repository/docker/wwu77/final/general

### Running the Image
- macOS/Linux: `make report-macos`
- Windows (Git Bash/PowerShell): `make report-windows`
These targets create a `report/` folder on your host and mount it into the container at `/project/final_report`, so the generated `Final_Proj2.html` is saved locally.