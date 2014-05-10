# This "doppelganger" script tests an experimental feature that 
# would allow swirl to accept either assignment operator (`<-` or `=`).
# When the user enters an expression of class `=` (i.e. an assignment
# using `=`), it gets coverted to an expression of class `<-`.

# Define callback function. Once activated via addTaskCallback(),
# this function will receive the expression and value that the
# user enters at the R prompt. This imitates swirl's core
# functionality. The parse trees are printed only for testing
# purposes.
f <- function(expr, val, ok, vis) {
  if(is(expr, "=")) {
    # Make the switch
    dop <- doppel(expr)
    # Subset expression object to get the true expression
    expr <- dop[[1]]
  }
  print_diag(expr)
  TRUE
}

# Initialize callback
addTaskCallback(f, name="nick")

# Expects an expression of class `=` and converts it to `<-`.
doppel <- function(expr) {
  txt <- deparse(expr)
  dop <- sub("=", "<-", txt)
  parse(text=dop)
}

# Print diagnostics, i.e. class and parse tree for given expression
print_diag <- function(expr) {
  message("EXPR:")
  print(expr)
  message("EXPR CLASS:")
  print(class(expr))
  message("PARSE TREE:")
  print(pryr::call_tree(expr))
  message(paste0(rep("#", getOption("width") - 2), collapse=""))
}

# Some examples
y = mean(c(4, 6, 88))
y <- mean(c(4, 6, 88))
x <- 33; y = 99; z = 1
ww <- paste("hello", "world", collapse=" ")

# Removes the callback
# removeTaskCallback("nick")

