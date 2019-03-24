library(tidyverse)
library(randomForest)
library(here)

data <- read_csv(here("data", "processed", "clean_test_data.csv"))

set.seed(100)

data <- data %>%
  select(
    city,
    year,
    weekofyear,
    reanalysis_air_temp_k,
    reanalysis_min_air_temp_k,
    station_min_temp_c,
    reanalysis_tdtr_k,
    station_diur_temp_rng_c
  ) %>%
  mutate_if(is.character, as.factor)

model <- readRDS(here("models", "trained_model_with_random_forest.rds"))

predictions <- predict(model, data, type = "response", norm.votes = TRUE, predict.all = FALSE, proximity = FALSE, nodes = FALSE)

data %>%
  add_column(total_cases = round(predictions)) %>%
  select(city, year, weekofyear, total_cases) %>%
  write_csv(here("data", "processed", "submission.csv"))
