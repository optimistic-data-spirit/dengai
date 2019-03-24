library(tidyverse)
library(here)

remove(list = ls()) # clear workspace memory

labels <- read_csv(here("data", "raw", "dengue_labels_train.csv"))
features <- read_csv(here("data", "raw", "dengue_features_train.csv"))

training <- merge(labels, features, by = c("city", "year", "weekofyear"))

write_csv(training, path = here("data", "interim", "training.csv"))
