library(tidyverse)
library(randomForest)
library(here)

training <- read_csv(here("data", "processed", "training.csv"))

set.seed(100)

train <- training %>%
 select(city,
        year,
        weekofyear,
        total_cases,
        reanalysis_air_temp_k,
        reanalysis_min_air_temp_k, 
        station_min_temp_c,
        reanalysis_tdtr_k,
        station_diur_temp_rng_c) %>%
 mutate_if(is.character, as.factor)


model <- randomForest(total_cases ~ ., data = train, ntree = 500, mtry = 6, importance = TRUE)
importance(model)

saveRDS(model, here("models", "trained_model_with_random_forest.rds"))
