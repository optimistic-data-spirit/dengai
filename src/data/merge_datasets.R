library(tidyverse)
library(here)

remove(list = ls()) # clear workspace memory

labels <- read_csv(here("data", "raw", "dengue_labels_train.csv"))
features <- read_csv(here("data", "raw", "dengue_features_train.csv"))

merged_dataset <- merge(labels, features, by = c("city", "year", "weekofyear"))

write_csv(merged_dataset, path = here("data", "interim", "merged_dataset.csv"))
