AUTO_DETECT_NEWVAR <- FALSE

yhat_test <- function() {
  e <- get("e", parent.frame())
  yhat.predict("auto_grader", data.frame(ans = e$val), silent = TRUE)
}

yhat_test2 <- function() {
  e <- get("e", parent.frame())
  sub <- data.frame(expr = deparse(e$expr), stringsAsFactors = FALSE)
  # res <- model.predict(sub) # For testing purposes only
  res <- yhat.predict("auto_grader3", sub, silent = TRUE)
  if(!is.na(res$mes)) swirl:::swirl_out(res$mes)
  res$is_correct
}

##########################################
## Code used to deploy yhat auto_grader ##
##########################################

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


###########################################
## Code used to deploy yhat auto_grader3 ##
###########################################

library(yhatr)

model.transform <- function(df) {
  df
}

model.predict <- function(df) {
  # Get expr and val
  expr <- parse(text = df$expr)[[1]]
  tempenv <- new.env()
  val <- try(eval(expr, tempenv), silent = TRUE)

  # Check if vector is numeric
  if(!is.numeric(val)) {
    res <- data.frame(is_correct = FALSE,
                      mes = "Your vector is not numeric!"
    )
    return(res)
  }
  # Check if vector is of length 3
  if(!(length(val) == 3)) {
    res <- data.frame(is_correct = FALSE,
                      mes = "Your vector is not of length 3!"
    )
    return(res)
  }
  # Check if variable called x is created
  if(!("x" %in% ls(tempenv))) {
    res <- data.frame(is_correct = FALSE,
                      mes = "You didn't create a new variable called x!"
    )
    return(res)
  }
  # If none of the tests above fail
  data.frame(is_correct = TRUE, mes = NA)
}

yhat.config <- c(username = "nick.carchedi@gmail.com",
                 apikey = "b31055ba97c67d31b779cddf7fdfacad",
                 env = "http://sandbox.yhathq.com")

yhat.deploy("auto_grader3")

