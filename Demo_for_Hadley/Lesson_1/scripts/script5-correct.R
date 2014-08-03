both %>%
  ggvis(~delay) %>%
  layer_histograms(binwidth = input_slider(1, 15, value = 5)) %>%
  print
