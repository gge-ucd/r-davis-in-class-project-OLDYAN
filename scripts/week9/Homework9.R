#Homework 9 ----
library(lubridate)
library(tidyverse)
library(ggplot2)
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
mloa_1 = mloa %>%
  filter(rel_humid!=-99) %>%
  filter(temp_C_2m!=-999.9) %>%
  filter(windSpeed_m_s!=-999.9) %>%
  mutate(datetime=ymd_hm(paste0(year,"-",month,"-",day," ",hour24,":",min),tz="UTC")) %>%
  mutate(datetimeLocal=with_tz(datetime,tz="Pacific/Honolulu"))
mloa_1 %>% mutate(monthLocal=month(datetimeLocal,label=T),
                  hourLocal=hour(datetimeLocal)) %>%
  group_by(monthLocal,hourLocal,) %>%
  summarise(temp_mean=mean(temp_C_2m)) %>% 
  ggplot(aes(x=monthLocal,y=temp_mean,color=hourLocal))+
  geom_point()+
  theme_bw()+
  scale_color_viridis_c()+
  xlab("Month") +
  ylab("Temperature")
#
