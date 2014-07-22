cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

# reward packages for being small
