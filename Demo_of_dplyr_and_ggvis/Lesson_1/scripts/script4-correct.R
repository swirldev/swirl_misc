# Create a plot following these instructions, in order:
#
# 1. Use ggvis() to map x to temp and y to delay (recall
# the ~temp notation)
# 2. Use layer_points() to create a scatterplot
# 3. Use layer_smooths() to add a smoothing line

both %>%
  ggvis(x = ~temp, y = ~delay) %>%
  layer_points() %>%
  layer_smooths() %>%
  print # Keep the print statement to see the result
