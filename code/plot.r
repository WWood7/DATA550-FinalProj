library(ggplot2)
library(mgcv)
library(scales)


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

fit <- gam(lung_cancer ~ s(age) + gender + radon_exposure + asbestos_exposure + 
           s(pack_years) + secondhand_smoke_exposure + copd_diagnosis + 
           alcohol_consumption + family_history, 
           data = data, family = binomial)

# create a dummy data for prediction with proper factor levels
dummy_data <- data.frame(
    age = 50,
    gender = factor("Male", levels = levels(data$gender)),
    radon_exposure = factor("Low", levels = levels(data$radon_exposure)),
    asbestos_exposure = factor("No", levels = levels(data$asbestos_exposure)),
    pack_years = seq(0, 50, 0.1),
    secondhand_smoke_exposure = factor("No", levels = levels(data$secondhand_smoke_exposure)),
    copd_diagnosis = factor("No", levels = levels(data$copd_diagnosis)),
    alcohol_consumption = factor("None", levels = levels(data$alcohol_consumption)),
    family_history = factor("No", levels = levels(data$family_history))
)

# predict the probability of developing lung cancer
pred <- predict(fit, newdata = dummy_data, type = "response")

# plot the result
plot <- ggplot(data = dummy_data, aes(x = pack_years, y = pred)) +
    geom_line(color = "darkred", linewidth = 1.2) +
    scale_y_continuous(
        labels = scales::percent_format(accuracy = 1),
        limits = c(0, max(pred) * 1.05),
        breaks = scales::pretty_breaks(n = 6)
    ) +
    scale_x_continuous(
        breaks = scales::pretty_breaks(n = 8),
        limits = c(0, 50)
    ) +
    labs(
        title = "Predicted Lung Cancer Risk by Smoking Exposure",
        subtitle = "50-year-old male with no other risk factors",
        x = "Pack Years (Packs per day × Years of smoking)",
        y = "Predicted Probability of Lung Cancer",
        caption = "Based on GAM model fitted to lung cancer risk dataset"
    ) +
    theme_minimal() +
    theme(
        plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
        plot.subtitle = element_text(size = 11, hjust = 0.5, color = "gray60"),
        plot.caption = element_text(size = 9, color = "gray50"),
        axis.title = element_text(size = 11, face = "bold"),
        axis.text = element_text(size = 10),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(color = "gray90", size = 0.5),
        plot.background = element_rect(fill = "white", color = NA)
    )
ggsave("output/plot.png", width = 8, height = 6)
