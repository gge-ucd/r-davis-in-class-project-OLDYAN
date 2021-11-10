#Homework 7 ----
library(tidyverse)
library(ggplot2)
gapminder = read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")
str(gapminder)
head(gapminder)
dat = gapminder %>%
  select(country,year,pop,continent) %>%
  filter(year>1997) %>%
  pivot_wider(names_from=year,values_from=pop) %>%
  mutate(pop_change=`2007`-`2002`)
head(dat)
dat %>% filter(continent!="Oceania") %>%
  ggplot(aes(x=reorder(country,pop_change),y=pop_change)) +
    geom_col(aes(fill=continent)) +
    theme() + 
    facet_wrap(~continent, scales="free") +
    scale_fill_hue() +
    theme(axis.text.x=element_text(angle=45,hjust=1),legend.position="none") +
    xlab("Country") +
    ylab("Change in Population Between 2002 and 2007")
#