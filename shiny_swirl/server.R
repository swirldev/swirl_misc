library(shiny)

shinyServer(function(input, output) {
	
  # Output current unit class selected for testing purposes
  output$unitText <- renderText({
    paste("Unit class selected:", input$class)
  })
  
  # Output current question type selected for testing purposes
  output$questionText <- renderText({
    paste("Question type selected:", input$question_type)
  })
  
  # When submit button is pressed, it's value increments to 1
  observe({
    if(input$finalSubmit == 0)
      return()
    
    # Set up return values
    return_vals <- list(Class = input$class,
                        Output = input$output,
                        AnswerChoices = input$answer_choices,
                        CorrectAnswer = input$correct_answer,
                        AnswerTests = input$answer_tests,
                        Hint = input$hint,
                        Figure = input$figure,
                        FigureType = input$figure_type,
                        VideoLink = input$video_link)
    
    # Return only non-empty values
    stopApp(return_vals)
  })
})