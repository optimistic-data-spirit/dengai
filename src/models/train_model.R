library(tidyverse)
library(randomForest)
library(here)

training <- read_csv(here("data", "processed", "clean_training_data.csv"))

set.seed(100)

train <- training %>%
  select(
    city,
    year,
    weekofyear,
    total_cases,
    reanalysis_air_temp_k,
    reanalysis_min_air_temp_k,
    station_min_temp_c,
    reanalysis_tdtr_k,
    station_diur_temp_rng_c,
    ndvi_ne,
    ndvi_nw,
    ndvi_se,
    ndvi_sw,
    reanalysis_max_air_temp_k,
    reanalysis_relative_humidity_percent,
    reanalysis_avg_temp_k
  ) %>%
  mutate_if(is.character, as.factor)


model <- randomForest(total_cases ~ ., data = train, ntree = 500, mtry = 6, importance = TRUE)
importance(model)

saveRDS(model, here("models", "trained_model_with_random_forest.rds"))
