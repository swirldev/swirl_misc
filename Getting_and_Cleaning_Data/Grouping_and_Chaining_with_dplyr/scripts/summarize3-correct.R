# Don't change any of the code below. Just type submit()
# when you think you understand it.

result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(count),
    avg_bytes
  )

print(result2)
