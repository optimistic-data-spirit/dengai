library(tidyverse)
library(mice)
library(here)

remove(list=ls()) # clear workspace memory

merged_dataset <- read_csv(here("data", "interim", "merged_dataset.csv"))
test <- read_csv(here("data", "raw", "dengue_features_test.csv"))

clean_data <- function(dataset){
  complete(mice(dataset,m=5,maxit=50,meth='pmm',seed=500),1)
}

clean_data(merged_dataset) %>%
  select(-reanalysis_sat_precip_amt_mm) %>% 
  mutate(
    precipitation_amt_mm = lag(precipitation_amt_mm, 3, order_by = week_start_date), 
    reanalysis_air_temp_k = lag(reanalysis_air_temp_k, 3, order_by = week_start_date),
    reanalysis_avg_temp_k = lag(reanalysis_avg_temp_k, 3, order_by = week_start_date),
    reanalysis_dew_point_temp_k = lag(reanalysis_dew_point_temp_k, 3, order_by = week_start_date),
    reanalysis_max_air_temp_k = lag(reanalysis_max_air_temp_k, 3, order_by = week_start_date),
    reanalysis_min_air_temp_k = lag(reanalysis_min_air_temp_k, 3, order_by = week_start_date),
    reanalysis_precip_amt_kg_per_m2 = lag(reanalysis_precip_amt_kg_per_m2, 3, order_by = week_start_date),
    reanalysis_relative_humidity_percent = lag(reanalysis_relative_humidity_percent, 3, order_by = week_start_date),
    reanalysis_specific_humidity_g_per_kg = lag(reanalysis_specific_humidity_g_per_kg, 3, order_by = week_start_date),
    reanalysis_tdtr_k = lag(reanalysis_tdtr_k, 3, order_by = week_start_date),
    station_avg_temp_c = lag(station_avg_temp_c, 3, order_by = week_start_date),
    station_diur_temp_rng_c = lag(station_diur_temp_rng_c, 3, order_by = week_start_date),
    station_max_temp_c = lag(station_max_temp_c, 3, order_by = week_start_date),
    station_min_temp_c = lag(station_min_temp_c, 3, order_by = week_start_date),
    station_precip_mm = lag(station_precip_mm, 3, order_by = week_start_date)
  ) %>% 
  na.omit() %>%
  write_csv(here("data", "processed", "clean_training_data.csv"))

clean_data(test) %>%
  select(-reanalysis_sat_precip_amt_mm) %>%
  write_csv(here("data", "processed", "clean_test_data.csv"))
