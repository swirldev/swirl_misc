# Accomplish the following objectives using the %>% operator:
#
# 1. filter() the flights data so that we are only dealing
# with flights that originated in "EWR"
# 2. Use group_by() to group the data by year, month, and
# day, in that order
# 3. Summarize the data by creating two new variables:
#     * delay = mean(dep_delay, na.rm = TRUE)
#     * cancelled = mean(is.na(dep_delay))

daily <- flights %>%
  filter(origin == "") %>% # Fill in the origin
  group_by() %>% # What are we grouping by?
  summarise(
    delay = mean(dep_delay, na.rm = TRUE),
    cancelled = mean(is.na(dep_delay))
  )
