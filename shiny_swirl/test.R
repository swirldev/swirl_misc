library(shiny)

getContent <- function() {
  runApp(launch.browser = rstudio::viewer)
}

content <- getContent()
str(content)