#Week 5 Homework ----
library(tidyverse)
surveys = read_csv("data/portal_data_joined.csv")
surveys_wide = surveys %>%
  filter(complete.cases(hindfoot_length)) %>%
  group_by(genus,plot_type) %>%
  summarise(mean_hindfoot_length=mean(hindfoot_length)) %>%
  pivot_wider(names_from=plot_type,values_from=mean_hindfoot_length) %>%
  arrange(Control)
surveys_wide
#
summary(surveys$weight)
#ifelse.
surveys %>%
  mutate(weight_cat=ifelse(weight<=20,"small",
                           ifelse(weight>20&weight<48,"medium","large")))
#casewhen.
surveys %>%
  mutate(weight_cat=case_when(weight<=20~"small",
                              weight>20&weight<48~"medium",
                              weight>=48~"large"))
#or
surveys %>%
  mutate(weight_cat=case_when(weight<=20~"small",
                              weight>20&weight<48~"medium",
                              is.na(weight)~NA_character_,
                              T~"large"))
#The "else" argument in case_when() includes NAs, but "else" argument in ifelse() does not include NAs.
#Thus we do not use "else" argument in case_when() here; instead, we clarify the argument "weight>=48~"large"" or remove NAs.
#Bonus
surveys %>%
  mutate(weight_cat=case_when(weight<=summary(surveys$weight)[2]~"small",
                              weight>summary(surveys$weight)[2]&weight<summary(surveys$weight)[5]~"medium",
                              weight>=summary(surveys$weight)[5]~"large"))
