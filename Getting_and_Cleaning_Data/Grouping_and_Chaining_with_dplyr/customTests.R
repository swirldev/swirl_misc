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
