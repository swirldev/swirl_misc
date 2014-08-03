### NOTE: To save time, I've already completed this script
### for you. Just type submit() at the prompt to continue.

# Accomplish the following goals using the %>% operator:
#
# 1. filter() the weather data so that we're only looking
# at weather with origin == "EWR"
# 2. Use group_by() to group the data by year, month, and
# day, in that order
# 3. Summarize the data using 3 new variables:
#     * temp = mean(temp, na.rm = TRUE)
#     * wind = mean(wind_speed, na.rm = TRUE)
#     * precip = sum(precip, na.rm = TRUE)

daily_weather <- weather %>%
  filter(origin == "EWR") %>%
  group_by(year, month, day) %>%
  summarise(
    temp = mean(temp, na.rm = TRUE),
    wind = mean(wind_speed, na.rm = TRUE),
    precip = sum(precip, na.rm = TRUE)
  )
