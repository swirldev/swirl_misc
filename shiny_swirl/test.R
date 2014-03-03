library(shiny)
library(yaml)

# Write a single unit using shiny GUI
write_unit <- function(file) {
  unit <- runApp(launch.browser = rstudio::viewer)
  cat(as.yaml(unit), file=file, sep="\n", append=TRUE)
}

author_new <- function(file = "test_lesson") {
  # Open file - file.edit() won't open .yaml files?
  file.edit(file)
  # Start authoring - press Esc to exit infinite loop
  while(1 != 0){
    write_unit(file)
  }
}