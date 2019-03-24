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
  write_csv(here("data", "processed", "clean_training_data.csv"))

clean_data(test) %>%
  select(-reanalysis_sat_precip_amt_mm) %>%
  write_csv(here("data", "processed", "clean_test_data.csv"))
