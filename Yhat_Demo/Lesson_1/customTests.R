AUTO_DETECT_NEWVAR <- FALSE

yhat_test <- function() {
  e <- get("e", parent.frame())
  yhat.predict("auto_grader", data.frame(ans = e$val), silent = TRUE)
}

#########################################
## Code used to deploy yhat autograder ##
#########################################

# library(yhatr)
#
# model.transform <- function(df) {
#   df
# }
#
# model.predict <- function(df) {
#   ans <- as.character(df$ans)
#   data.frame(is_correct = identical(ans, "Batman"))
# }
#
# yhat.config <- c(username = "nick.carchedi@gmail.com",
#                  apikey = "b31055ba97c67d31b779cddf7fdfacad",
#                  env = "http://sandbox.yhathq.com")
#
# yhat.deploy("auto_grader")
