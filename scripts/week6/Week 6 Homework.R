#Week6 HW ----
library(tidyverse)
library(ggplot2)
gapminder = read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")
#q1.
gapminder %>%
  group_by(continent,year) %>%
  summarise(lifeExp_mean=mean(lifeExp)) %>%
  ggplot(aes(x=year,y=lifeExp_mean,color=continent))+
  geom_point() +
  geom_line()
#q2.
ggplot(gapminder,aes(x=gdpPercap, y=lifeExp)) +
  geom_point(aes(color=continent),size=0.25) + 
  scale_x_log10() +
  geom_smooth(method='lm',color='black',linetype='dashed') +
  theme_bw()
#The "scale_x_log10()" line of code scales down the changing trend of gdpPercap from an exponential
#level to a linear level in order to fit into the formula "y ~ x"; the "geom_smooth()" can add a 
#smoothed linear regression line to the plot with the formula "y ~ x".
#
#Challenge.
ggplot(gapminder,aes(x=gdpPercap,y=lifeExp)) +
  geom_point(aes(color=continent,size=pop)) + 
  scale_x_log10() +
  geom_smooth(method='lm',color='black',linetype='dashed') +
  theme_bw()
#q3.
countries = c("Brazil","China","El Salvador","Niger","United States")
gapminder %>%
  filter(country%in%countries) %>%
  ggplot(aes(x=country,y=lifeExp)) +
  geom_boxplot() +
  geom_jitter(color="tomato") +
  theme_bw() +
  xlab("Country") + ylab("Life Expectancy") +
  ggtitle("Life Expectancy of Five Countries")
#