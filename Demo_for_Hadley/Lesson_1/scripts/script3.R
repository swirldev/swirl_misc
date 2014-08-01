both <- daily %>%
  inner_join(daily_weather) %>%
  ungroup() %>%
  mutate(date = as.Date(ISOdate(year, month, day)))
