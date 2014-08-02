# extract  Extract one column into multiple columns.
# extract_numeric	Extract numeric component of variable.
# gather	Gather columns into key-value pairs.
# separate	Separate one column into multiple columns.
# spread	Spread a key-value pair across multiple columns.
# spread_	Standard-evaluation version of 'spread'.
# unite	Unite multiple columns into one.

library(dplyr)
library(tidyr)

sat <- tbl_df(read.csv('Getting_and_Cleaning_Data/Tidying_Data_with_tidyr/sat13'))
sat1 <- select(sat, -contains("total"))
sat1 <- gather(sat1, column, count, -score_range)
sat1 <- separate(sat1, column, c("part", "sex"))
sat1

by_part <- group_by(sat1, part, sex)
sat2 <- mutate(by_part,
               total = sum(count),
               prop = count / total)


arrange(sat1, desc(count))

sat %>%
  gather("column", "count", -score_range) %>%
  separate(column, c("part", "sex"))

