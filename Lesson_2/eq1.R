path <- .path_to_file("swirl_misc", "Lesson_2", "eq1.Rmd")

tf <- tempfile()
dir.create(tf)
htmlFile <- file.path(tf, "index.html")
suppressWarnings(rmarkdown::render(path, output_format = "html_document", output_file = htmlFile))
rstudioapi::viewer(htmlFile)