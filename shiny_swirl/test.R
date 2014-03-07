library(shiny)
library(yaml)

# Write a single unit using shiny GUI
write_unit <- function(lessonFile) {
  # Returns unit info, or NULL if done
  vals <- runApp("~/Dropbox/R_Working_Directory/swirl_misc/shiny_swirl/",
                 launch.browser = rstudio::viewer)
  # If NULL, then user is done
  if(is.null(vals)) {
    return(NULL)
  }
  # Write unit info to file
  cat(paste0("\n- ", paste0(names(vals), ": ", vals, collapse="\n  "), "\n"),
      file=lessonFile, append=TRUE)
  # Return TRUE if user not done yet
  return(TRUE)
}

newYaml <- function(course, lesson) {
  courseDir <<- gsub(" ", "_", course)
  lessonDir <<- gsub(" ", "_", lesson)
  if(!file.exists(lessonDir)) {
    dir.create(file.path(courseDir, lessonDir), recursive=TRUE)
    # Move into course directory
    setwd(courseDir)
  }
  writeLines("# Put initialization code in this file.", 
             file.path(lessonDir, "initLesson.R"))
  writeLines("# Put custom tests in this file.", 
             file.path(lessonDir,"customTests.R"))
  lessonFile <<- file.path(lessonDir, "lesson")
  writeLines(c("- Class: meta", 
               paste("  Course:", course),
               paste("  Lesson:", lesson),
               "  Author: Your name goes here",
               "  Type: Standard",
               "  Organization: Your organization goes here (optional)",
               paste("  Version:", packageVersion("swirl"))),
             lessonFile)
  file.edit(lessonFile)
  return(lessonFile)
}

go <- function(course = "My Test Course", lesson = "My Test Lesson") {
  # Create course skeleton and open new lesson file
  lessonFile <- newYaml(course, lesson)
  # Initialize result
  result <- TRUE
  # Loop until user is done
  while(!is.null(result)) {
    result <- write_unit(lessonFile)
  }
  invisible()
}