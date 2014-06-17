### This only works for swirl lessons formatted in yaml ###

library(yaml)
library(stringr)
library(knitrBootstrap)

makechunk <- function(item) {
  paste("```{r}", item, "```", sep="\n")
}

makechunk_noecho <- function(item) {
  paste("```{r, echo=FALSE}", item, "```", sep="\n")
}

makemult <- function(item) {
  answers <- unlist(str_split(item, ";"))
  answers <- str_trim(answers)
  nums <- paste0(seq(length(answers)), ".")
  paste(nums, answers, collapse="\n")
}

makemd <- function(unit) UseMethod("makemd")

makemd.default <- function(unit) {
  stop("No unit class specified!", unit)
}

makemd.text <- function(unit) {
  paste(unit[['Output']], 
        sep="\n\n")
}

makemd.cmd_question <- function(unit) {
  paste(unit[['Output']], 
        makechunk(unit[['CorrectAnswer']]), 
        sep="\n\n")
}

makemd.mult_question <- function(unit) {
  paste(unit[['Output']], 
        makemult(unit[['AnswerChoices']]), 
        unit[['CorrectAnswer']], 
        sep="\n\n")
}

swirl2html <- function(lessonPath, destDir) { 
  # Set destination file for Rmd
  destrmd <- file.path(destDir, "lesson.Rmd")
  # Load yaml
  les <- yaml.load_file(lessonPath)
  # Get and remove meta
  meta <- unlist(les[1])
  les <- les[-1]
  # Write meta to document header
  cat('---',
      paste('title:', meta['Lesson']),
      'output:',
      '  html_document:',
      '    theme: spacelab',
      '---\n',
      sep="\n", file=destrmd)
  # Get initLesson.R info and write init chunk w/ no echo
  initpath <- file.path(dirname(lessonPath), "initLesson.R")
  initcode <- paste(readLines(initpath, warn=FALSE), collapse="\n")
  initcode <- paste("suppressPackageStartupMessages(library(swirl))", 
                    initcode, sep="\n")
  cat(makechunk_noecho(initcode), "\n\n", file=destrmd, append=TRUE)
  # Write the rest of the content
  for(unit in les) {
    class(unit) <- unit[['Class']]
    out <- paste(makemd(unit), "\n\n")
    cat(out, file=destrmd, append=TRUE)
    invisible()
  }
  message("Opening R Markdown file...")
  file.edit(destrmd)
  message("Knitting html...")
  rmarkdown::render(destrmd)
  # Path to html document
  desthtml <- file.path(destDir, "lesson.html")
  message("Opening html document...")
  browseURL(desthtml)
}
