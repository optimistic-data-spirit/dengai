library(tidyverse)
library(mice)
library(here)

remove(list=ls()) # clear workspace memory

clean_data <- function(dataset){
  complete(mice(dataset,m=5,maxit=50,meth='pmm',seed=500),1)
}

merged_dataset <- read_csv(here("data", "interim", "merged_dataset.csv"))

clean_data(merged_dataset) %>%
  select(-reanalysis_sat_precip_amt_mm) %>%
  write_csv(here("data", "processed", "training.csv"))        
