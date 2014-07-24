dt1 <- '1985-08-25' # most common - big to small
dt2 <- '1985/08/25' # alternative
dt3 <- '85-8-25' # make sure you specify year fully

# Also handles vectors of dates
dt4 <- c('2014-05-14', '2014-09-22')

# Often in the US, we refer to mm/dd/yyyy
dt5 <- '08.25.1985'
dt6 <- 'Aug 25, 1985'
dt7 <- 08251985

# Do whatever you want
dt8 <- '25 August 1985'
dt9 <- '25081985'

# But be careful, it's not magic!
dt10 <- '1985825'


dt11 <- '2014-08-23 17:23:02'
