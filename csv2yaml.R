# Converts a lesson.csv file to an equivalent lesson.yaml file.
csv2yaml <- function(course, lesson, author, type, organization, version, csvfile, yamlfile){
  library(yaml)
  # The old csv files have names like 'Tag' which aren't recognized by the current parse_content.yaml
  parse_content_names <- c('Class', 'Output', 'CorrectAnswer', 'AnswerChoices', 'AnswerTests', 
                           'Hint', 'Figure', 'FigureType', 'VideoLink')
  csv <- read.csv(csvfile, as.is=TRUE)
  yml <- list(list(Class="meta", Course=course, Lesson=lesson, Author=author, 
                   Type=type, Organization=organization, Version=version))
  for(n in 1:nrow(csv)){
    nxt = list()
    for(field in intersect(names(csv), parse_content_names)){
      if(!is.na(csv[n, field]) && !(''==csv[n, field]))nxt[[field]] <- csv[n,field]
    }
    yml[[n+1]] <- nxt
  }
  yml <- as.yaml(yml)
  yml <- gsub("- Class:", "\n- Class:", yml)
  writeLines(yml, yamlfile)
}

# Replaces all lesson.csv files in a course by equivalent lesson.yaml files, renaming
# lesson.csv to old.csv for purging after the yaml files are tested.
csv2yaml_course <- function(course_dir, author="Nick Carchedi", type="Standard", 
                            organization="JHU Biostatistics", version="1.0.0"){
  lessons <- dir(course_dir)
  temp <- strsplit(course_dir, "/")[[1]]
  course <- gsub("_", " ", temp[length(temp)])
  for(lesson in lessons){
    csvfile <- file.path(course_dir, lesson, "lesson.csv")
    if(file.exists(csvfile)){
      yamlfile <- file.path(course_dir, lesson, "lesson.yaml")
      csv2yaml(course, gsub("_", " ", lesson), author, type, 
               organization, version, csvfile, yamlfile)
      file.rename(csvfile, file.path(course_dir, lesson, "old.csv"))
    }
  }
}

# Purges old.csv files once the yaml files have been tested.
purge_old_csv <- function(course_dir){
  lessons <- dir(course_dir)
  for(lesson in lessons){
    oldcsv <- file.path(course_dir, lesson, "old.csv")
    if(file.exists(oldcsv)){
      file.remove(oldcsv)
    }
  }
} 