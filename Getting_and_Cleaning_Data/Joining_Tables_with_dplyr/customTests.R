AUTO_DETECT_NEWVAR <- FALSE

prints_var <- function(varname) {
  e <- get("e", parent.frame())
  any_of_exprs(varname, paste0('print(', varname, ')'))
}

gets_help <- function(funcname) {
  e <- get("e", parent.frame())
  any_of_exprs(paste0('?', funcname),
               paste0('help(', funcname, ')'))
}
