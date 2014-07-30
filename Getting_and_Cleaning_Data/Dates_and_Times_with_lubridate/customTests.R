func_uses_args <- function(...) {
  e <- get("e", parent.frame())
  # Get user's expression
  expr <- e$expr
  # Capture names of correct args
  correct_args <- list(...)
  # Check for the presence of each correct arg in the expr names
  match_found <- try(sapply(correct_args, function(arg) arg %in% names(expr)))
  # If something is weird, return FALSE
  if(!all(is.logical(match_found))) {
    return(FALSE)
  }
  # Did we find all desired args?
  all(match_found)
}
