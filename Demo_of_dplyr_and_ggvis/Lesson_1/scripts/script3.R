# Complete the following tasks to form our final dataset:
#
# 1. Combine daily with daily_weather using inner_join()
# 2. ungroup() the data
# 3. Use mutate() to create a new column called date, which
# gets the value as.Date(ISOdate(year, month, day))

both <- daily %>%
  inner_join(daily_weather) %>%
  ungroup() %>%
  mutate(date = as.Date(ISOdate(year, month, day)))
