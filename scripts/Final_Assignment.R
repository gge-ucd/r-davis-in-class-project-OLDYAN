#Final Assignment ----
library(tidyverse)
library(ggplot2)
flights = read.csv("data/nyc_13_flights_small.csv")
planes = read.csv("data/nyc_13_planes.csv")
weather = read.csv("data/nyc_13_weather.csv")
#Q.1
dat.1 = left_join(flights,weather)
str(dat.1)
plot_1 = ggplot(dat.1,aes(x=precip,y=dep_delay))+
  geom_point()+
  geom_smooth(method="lm",col="red")+
  theme_bw()
ggsave(path='plots',filename="plot_1.png")
#
#Q.2
library(lubridate)
plot_2 = dat.1 %>% 
  filter(month>8) %>%
  mutate(date=ymd(paste0(year,"-",month,"-",day))) %>%
  group_by(date,dep_delay) %>%
  mutate(dep_delay_mean=mean(dep_delay)) %>%
  ggplot(aes(x=date,y=dep_delay_mean,color=carrier))+
  geom_point()+
  theme_bw()+
  scale_fill_hue()
ggsave(path='plots',filename="plot_2.png")
#
#Q.3
dat.2 = dat.1 %>%
  mutate(date=ymd(paste0(year,"-",month,"-",day))) %>%
  filter(complete.cases(temp)) %>%
  group_by(date,temp) %>%
  mutate(mean_temp=mean(temp)) %>%
  select(origin,date,mean_temp)
write.csv(dat.2,"data/mean_temp_by_origin.csv")
#
#Q.4
time_convert_fun = function(time_length,unit){
  if(unit=='min'){
    result=time_length/60
  }else{
      result=time_length*60
      }
  return(result)
  }
save(time_convert_fun,file="scripts/customFunctions.R")
dat.3 = dat.1 %>%
  mutate(dep_delay_hrs=time_convert_fun(dep_delay,'min'))
dat.3
plot_3 = ggplot(dat.3,aes(x=dep_delay_hrs,y=carrier,fill=carrier))+
  geom_boxplot()
plot_3  
#
#Q.5
plot_3_1 = ggplot(dat.3,aes(x=dep_delay_hrs,y=carrier,fill=carrier))+
  geom_boxplot(outlier.alpha=0.1)+
  scale_color_viridis_d()+
  ggtitle("Departure Delay Time in Relation to Carrier")+
  xlab("Departure Delay Time (hrs)")+
  ylab("Carrier")+
  theme_bw()+
  theme(plot.title=element_text(size=16,hjust=0.5),
        legend.justification="top" )
plot_3_1
ggsave(path='plots',filename="plot_3_1.png")
#
