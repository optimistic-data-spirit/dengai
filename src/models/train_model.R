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
    week_start_date,
    ndvi_ne,
    ndvi_nw,
    ndvi_se,
    ndvi_sw,
    precipitation_amt_mm,
    reanalysis_air_temp_k,
    reanalysis_avg_temp_k,
    reanalysis_dew_point_temp_k,
    reanalysis_max_air_temp_k,
    reanalysis_min_air_temp_k,
    reanalysis_precip_amt_kg_per_m2,
    reanalysis_relative_humidity_percent,
    reanalysis_specific_humidity_g_per_kg,
    reanalysis_tdtr_k,
    station_avg_temp_c,
    station_diur_temp_rng_c,
    station_max_temp_c,
    station_min_temp_c,
    station_precip_mm
      ) %>%
  mutate_if(is.character, as.factor)

model <- randomForest(total_cases ~ ., data = train, ntree = 500, mtry = 6, importance = TRUE)
importance(model)

saveRDS(model, here("models", "trained_model_with_random_forest.rds"))
