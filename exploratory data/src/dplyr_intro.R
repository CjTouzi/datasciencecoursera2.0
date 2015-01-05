library(nycflights13)
library(dplyr)
head(flights)
str(flights)


planes <- group_by(flights, tailnum)
delay <- summarise(planes,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dist < 2000)
head(delay)
