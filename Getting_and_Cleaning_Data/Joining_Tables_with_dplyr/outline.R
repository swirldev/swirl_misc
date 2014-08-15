library(dplyr)
library(nycflights)

# help(package = nasaweather)
# ?atmos
# ?borders
# ?elev
# ?glaciers
# ?storms

n_storms <- storms %>%
  group_by(year, month) %>%
  summarize(n = n())

avg_temps <- atmos %>%
  group_by(year, month) %>%
  summarize(avg_temp = mean(temp),
            avg_pressure = mean(pressure)
  )


babynames %>%
  group_by(year) %>%
  summarize(n_names = n_distinct(name)) %>%
  ggvis(~year, ~n_names) %>%
  layer_points() %>%
  layer_smooths(stroke := "red")
