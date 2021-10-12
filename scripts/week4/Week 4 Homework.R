#Week 4 Homework ----
library(tidyverse)
#q1
surveys = read_csv("data/portal_data_joined.csv")
surveys
#q2
surveys %>% filter(weight>30&weight<60) %>% head()
#q3
str(surveys)
biggest_critters = surveys %>% filter(complete.cases(weight)) %>%
  group_by(species_id,sex) %>%
  summarise(weight_max=max(weight))
biggest_critters %>% arrange(weight_max)
biggest_critters %>% arrange(desc(weight_max))
#q4
surveys %>%
  filter(is.na(weight)) %>%
  group_by(year) %>%
  tally() %>%
  arrange(desc(n))
surveys %>%
  filter(is.na(weight)) %>%
  group_by(month) %>%
  tally() %>%
  arrange(desc(n))
surveys %>%
  filter(is.na(weight)) %>%
  group_by(day) %>%
  tally() %>%
  arrange(desc(n))
surveys %>%
  filter(is.na(weight)) %>%
  group_by(hindfoot_length) %>%
  tally() %>%
  arrange(desc(n))
surveys %>%
  filter(is.na(weight)) %>%
  group_by(genus) %>%
  tally() %>%
  arrange(desc(n))
surveys %>%
  filter(is.na(weight)) %>%
  group_by(species) %>%
  tally() %>%
  arrange(desc(n))
surveys %>%
  filter(is.na(weight)) %>%
  group_by(taxa) %>%
  tally() %>%
  arrange(desc(n))
surveys %>%
  filter(is.na(weight)) %>%
  group_by(plot_type) %>%
  tally() %>%
  arrange(desc(n))
#q5
surveys = surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id,sex) %>%
  mutate(weight_avg=mean(weight))
surveys_avg_weight = surveys %>%
  select(species_id,sex,weight,weight_avg)
surveys_avg_weight
#q6
surveys_avg_weight = surveys_avg_weight %>% 
  group_by(species_id,sex) %>%
  mutate(above_average = weight>weight_avg)
surveys_avg_weight
  
