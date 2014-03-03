library(shiny)

shinyServer(function(input, output) {
	
  output$unitText <- renderText({
    paste("Unit type selected:", input$unitType)
  })
  
  observe({
    if(input$finalSubmit == 0)
      return()
      
    stopApp(list(text = input$main_text,
                 correct_ans = input$correct_ans, 
                 hint = input$hint,
                 ans_tests = input$ans_tests))
  })
})