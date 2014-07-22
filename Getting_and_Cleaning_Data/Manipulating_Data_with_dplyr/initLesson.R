### Code used to download and save data
# logurl <- 'http://cran-logs.rstudio.com/2014/2014-07-08.csv.gz'
# filepath <- paste0('~/', basename(logurl))
# download.file(logurl, filepath)
# cranlog <- read.csv(filepath)
# write.csv(cranlog, 'Getting_and_Cleaning_Data/Manipulating_Data_with_dplyr/2014-07-08.csv')
# unlink(filepath)

# Make path to csv available to user
path2csv <- file.path(path.package('swirl'), 'Courses',
                      'Getting_and_Cleaning_Data',
                      'Manipulating_Data_with_dplyr',
                      '2014-07-08.csv')
