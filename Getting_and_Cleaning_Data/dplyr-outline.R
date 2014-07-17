### Manipulating data with dplyr - Getting and Cleaning Data ###

# Code to download data
# logurl <- 'http://cran-logs.rstudio.com/2014/2014-07-08.csv.gz'
# filepath <- paste0('~/', basename(logurl))
# download.file(logurl, filepath)
# cranlog <- read.csv(filepath)
# write.csv(cranlog, '~/Desktop/2014-07-08.csv')
# unlink(filepath)

path2csv <- file.path('~/Desktop/2014-07-08.csv')


### Intro
df <- read.csv(path2csv, as.is = TRUE)
dim(df)
head(df)
library(dplyr)
cran <- tbl_df(df)
cran
?manip

### select()
select(cran, ip_id, package, country) # reorders
select(cran, r_arch:country)
select(cran, -c(X:time, r_arch))
select(cran, ip_id:size)

### filter()
filter(cran, package == "swirl")
filter(cran, r_version == "3.1.1", country == "US")
filter(cran, country == "US" | country == "CA")
filter(cran, r_version >= "3.0.0", r_os == "linux-gnu")
filter(cran, !is.na(package))

### arrange()
arrange(cran, ip_id)
arrange(cran, package, ip_id)
arrange(cran, country, desc(r_version), ip_id)
arrange(cran, package, desc(version), ip_id)

### mutate()
cran1 <- select(cran, ip_id, package, size)
mutate(cran1, size_mb = size / 2^20)
mutate(cran1, size_mb = size / 2^20, size_gb = size_mb / 2^10)

### summarize()
summarize(cran, avg_bytes = mean(size))

### group_by()
packages <- group_by(cran, package)
downloads <- summarize(packages,
                       count = n(),
                       unique = n_distinct(ip_id),
                       avg_bytes = mean(size))

top_counts <- filter(downloads, count > 750)
arrange(top_downloads, desc(count))
head(arrange(top_downloads, desc(count)), 20)

top_unique <- filter(downloads, unique > 500)
arrange(top_unique, desc(unique))
head(arrange(top_unique, desc(unique)), 20)

filter(downloads, package == "swirl")

###

countries <- group_by(cran, country)
setup <- summarize(countries,
                   count = n(),
                   dist_packages = n_distinct(package),
                   prop_linux = mean(r_os == "linux-gnu", na.rm = TRUE),
                   prop64 = mean(r_arch == "x86_64", na.rm = TRUE))
setup_ss <- filter(setup, count > 1000)
arrange(setup_ss, desc(count))
arrange(setup_ss, desc(dist_packages))
arrange(setup_ss, desc(prop_linux))


my_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

summarize(countries,
          count = n(),
          dist_packages = n_distinct(package),
          os_mode = my_mode(r_os),
          process_mode = my_mode(r_arch))
                   

### Chaining
cran %>%  
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20)


