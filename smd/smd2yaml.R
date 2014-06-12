library(stringr)
library(yaml)
# path <- "/Users/sean/Desktop/kboot/lesson.Rmd"

smd2yaml <- function(path){
  text <- str_trim(readLines(path))
  yaml_result <- "- "
  splits <- c(grep("---", text), length(text))
  tree <- list()
  
  sapply(text, function(x){
    if(grepl("^\\s+$", x)){
      stop(paste("Illegal whitespace on line", which(text==x)))
    }
  })
  
  for(i in 1:(length(splits)-1)){
    # Split lesson into questions
    tree[[i]] <- text[splits[i]:splits[i+1]]
    
    # Purge syntactically irrelevant (sugary) lines
    tree[[i]] <- tree[[i]][-c(which(tree[[i]]=="---"), which(tree[[i]]==""))]
  }
  
  yaml_result <- paste0(yaml_result, tree[[1]][1], "\n")
  for(i in 2:length(tree[[1]])){
    yaml_result <- paste0(yaml_result, "  ", tree[[1]][i], "\n")
  }
  yaml_result <- paste0(yaml_result, "\n")
  
  for(i in 2:length(tree)){
    yaml_result <- str_c(yaml_result, as.yaml(list(.question_writer(tree[[i]]))), "\n")
  }
  
  cat(yaml_result, file="new_lesson.yaml")
}


# returns a yaml chunk
# vec: vector of strings
.question_writer <- function(vec){
  question <- list()
  
  # The first line is the question
  question$Output <- vec[1]
  
  # If a hint exists, add it
  if(length(sub("#", "", vec[which(grepl("^#", vec))])) > 0){
    question$Hint <- str_trim(sub("#", "", vec[which(grepl("^#", vec))]))
  }
  
  # If a CorrectAnswer exists, add it
  if(!is.na(vec[2]) & vec[2]=="```"){
    question$CorrectAnswer <- vec[3]
  }
  
  # If an Answer test exists, add it; else if there is an answer, make generic test
  if(.includes_string(vec, "```test")){
    question$AnswerTests <- paste0("omnitest(", vec[which(vec=="```test")+1], ")")
  } else if(!is.null(question$CorrectAnswer)){
    question$AnswerTests <- paste0("omnitest(correctExpr='", question$CorrectAnswer, "')")
  }
  
  # Look for multiple choice
  if(.includes_string(vec, "^-") & .includes_string(vec, "^*")){
    incorrect <- sub("^-\\s*", "", vec[which(grepl("^-", vec))])
    correct <- sub("^\\*\\s*", "", vec[which(grepl("^\\*", vec))])
    question$AnswerChoices <- paste0(c(incorrect, correct), collapse=";")
    question$CorrectAnswer <- correct
    question$AnswerTests <- paste0("omnitest(correctVal= '", correct, "')")
  }
  
  # Determine question class
  if(!is.null(question$AnswerChoices)){
    question$Class <- "mult_question"
  } else if(!is.null(question$CorrectAnswer)){
    question$Class <- "cmd_question"
  } else {
    question$Class <- "text"
  }
   
  question
}
  
#returns TRUE if string is in vec
.includes_string <- function(vec, string){
  length(which(grepl(string, vec))) > 0
}  
