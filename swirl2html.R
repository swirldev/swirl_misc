### This only works for swirl lessons formatted in yaml ###

library(yaml)
library(stringr)
library(knitrBootstrap)

makechunk <- function(item) {
  paste("```{r}", item, "```", sep="\n")
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
les <- yaml.load_file("~/Desktop/test.yaml")
les <- les[-1] # Remove meta
# Set dest path
dest <- "~/Desktop/test.md"
for(unit in les) {
  class(unit) <- unit[['Class']]
  out <- paste(makemd(unit), "\n\n")
  cat(out, file=dest, append=TRUE)
  invisible()
}
