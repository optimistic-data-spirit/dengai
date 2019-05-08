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
  
model <- readRDS(here("models", "trained_model_with_random_forest.rds"))

predictions <- predict(model, data, type = "response", norm.votes = TRUE, predict.all = FALSE, proximity = FALSE, nodes = FALSE)

data %>%
  add_column(total_cases = round(predictions)) %>%
  select(city, year, weekofyear, total_cases) %>%
  write_csv(here("data", "processed", "submission.csv"))
