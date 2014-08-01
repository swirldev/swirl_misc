both %>%
  ggvis(~temp, ~delay, fill = ~precip) %>%
  layer_points()
