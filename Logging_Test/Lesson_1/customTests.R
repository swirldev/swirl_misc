# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

# Get the swirl state
getState <- function(){
  # Whenever swirl is running, its callback is at the top of its call stack.
  # Swirl's state, named e, is stored in the environment of the callback.
  environment(sys.function(1))$e
}

getLog <- function(){
  getState()$log
}

create_log <- function(){
  temp <- tempfile()
  log_ <- getLog()
  nrow_ <- length(log_$question_number)
  log_tbl <- data.frame(user = rep(log_$user, nrow_),
                        course_name = rep(log_$course_name, nrow_),
                        lesson_name = rep(log_$lesson_name, nrow_),
                        question_number = log_$question_number,
                        correct = log_$correct,
                        attempt = log_$attempt,
                        skipped = log_$skipped,
                        datetime = log_$datetime,
                        stringsAsFactors = FALSE)
  write.csv(log_tbl, file = temp, row.names = FALSE)
  log_char <- readChar(temp, file.info(temp)$size)
  message("Paste the following into Google Forms:\n")
  message(base64encode(temp))
  message("\n")
}