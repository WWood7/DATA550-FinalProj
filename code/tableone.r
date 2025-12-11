library(table1)

data <- read.csv("data/lung_cancer_dataset.csv")

# factorize the categorical variables
data$gender <- factor(data$gender)
data$radon_exposure <- factor(data$radon_exposure)
data$asbestos_exposure <- factor(data$asbestos_exposure)
data$secondhand_smoke_exposure <- factor(data$secondhand_smoke_exposure)
data$copd_diagnosis <- factor(data$copd_diagnosis)
data$alcohol_consumption <- factor(data$alcohol_consumption)
data$family_history <- factor(data$family_history)
data$lung_cancer <- factor(data$lung_cancer)


label(data$age) <- "Age"
label(data$gender) <- "Gender"
label(data$pack_years) <- "Pack Years"
label(data$radon_exposure) <- "Radon Exposure"
label(data$asbestos_exposure) <- "Asbestos Exposure"
label(data$secondhand_smoke_exposure) <- "Secondhand Smoke Exposure"
label(data$copd_diagnosis) <- "COPD Diagnosis"
label(data$alcohol_consumption) <- "Alcohol Consumption"
label(data$family_history) <- "Family History"
label(data$lung_cancer) <- "Lung Cancer"

table1 <- table1(~ age + gender + pack_years + radon_exposure + asbestos_exposure + 
       secondhand_smoke_exposure + copd_diagnosis + alcohol_consumption + 
       family_history + lung_cancer, data = data)
saveRDS(table1, "output/table1.rds")