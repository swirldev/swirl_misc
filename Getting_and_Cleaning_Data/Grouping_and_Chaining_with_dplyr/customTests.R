AUTO_DETECT_NEWVAR <- FALSE

summarize1_test <- function() {
  # Get e and the script contents
  e <- get("e", parent.frame())
  contents <- e$script_contents

  # Put expression in e$expr
  e$expr <- try(parse(text = contents)[[1]], silent = TRUE)

  # Dispatch to omnitest
  omnitest('pack_sum <- summarize(by_package,
                                  count = n(),
                                  unique = n_distinct(ip_id),
                                  countries = n_distinct(country),
                                  avg_bytes = mean(size))'
           )
}

script_results_identical <- function(result_name) {
  # Get e
  e <- get('e', parent.frame())
  # Get user's result from global
  if(exists(result_name, globalenv())) {
    user_res <- get(result_name, globalenv())
  } else {
    return(FALSE)
  }
  # Source correct result in new env and get result
  tempenv <- new.env()
  local(source(e$correct_script_path, local = TRUE),
        envir = tempenv)
  correct_res <- get(result_name, tempenv)
  # Compare results
  identical(user_res, correct_res)
}
