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

# Set lesson path
lespath <- "swirl_courses/R_Programming/Apply_Family_of_Functions_-_Part_1/lesson.yaml"
les <- yaml.load_file(lespath)
les <- les[-1] # Remove meta
# Set dest path
dest <- "~/Desktop/applyfam.Rmd"
# Get initLesson.R info and write no echo chunk
initpath <- file.path(dirname(lespath), "initLesson.R")
initcode <- paste(readLines(initpath, warn=FALSE), collapse="\n")
initcode <- paste("suppressPackageStartupMessages(library(swirl))", 
                  initcode, sep="\n")
cat(makechunk_noecho(initcode), "\n\n", file=dest)
# Write the rest of the content
for(unit in les) {
  class(unit) <- unit[['Class']]
  out <- paste(makemd(unit), "\n\n")
  cat(out, file=dest, append=TRUE)
  invisible()
}
