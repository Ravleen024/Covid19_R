library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(gganimate)
library(gifski)
library(av)
library(gapminder)
library(png)

data<-read.csv(file.choose(),header = T)
head(data$date_confirmation)

datanew <- data %>% 
  mutate(date_confirmation = dmy(date_confirmation))
head(datanew$date_confirmation)


datanew %>% group_by(date_confirmation) %>% 
  summarise(count=n())%>%
  mutate(cuml = cumsum(count)) %>%
  ggplot(aes(x = date_confirmation, y = cuml)) +
  geom_line(color = 'red') +
  geom_point(size = 2) +
  geom_area(fill='red') +
  theme_bw() +
  ggtitle('Cumulative Cases On Daily Basis')+
  transition_reveal(cuml)
 
datanew$day <- day(datanew$date_confirmation)
datanew$month <- month(datanew$date_confirmation)

new <- datanew %>% 
  filter(month == 3) %>% 
  group_by(day, country) %>% 
  summarise(count = n())
new<- data.frame(complete(new, day, country,
                          fill = list(count = 0)))

new %>% filter(country == 'United States' |
                 country == 'France' |
                 country == 'United Kingdom' |
                 country == 'India') %>%
  ggplot(aes(x=day,y=count,
             group=country,
             color=country))+
  geom_line()+
  geom_point()+
  theme_bw()+
    ggtitle('Animated daily line plot')+
    transition_reveal(day)
  