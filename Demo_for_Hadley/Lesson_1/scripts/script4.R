both %>%
  ggvis(x = ~temp, y = ~delay) %>%
  layer_points() %>%
  layer_smooths()
