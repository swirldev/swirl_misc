library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Lesson Name Here"),
  
  sidebarPanel(
    # Select unit type
    selectInput("unitType", "Unit type:", 
                choices = c("Text", "Question", "Video", "Figure")),
    # If question unit, then select question type
    conditionalPanel(
      condition = "input.unitType == 'Question'",
      selectInput("questionType", "Question type:",
                  choices = c("Command", "Multiple", "Numeric", "Text"))
    )
  ),
  
  mainPanel(
		verbatimTextOutput("unitText"),
    
  	conditionalPanel(
    	condition = "input.unitType == 'Question' 
                      && input.questionType == 'Command'",
    	tags$textarea(id="main_text", rows=3, cols=40, 
    	              placeholder="Enter main text here..."),
    	tags$textarea(id="correct_ans", rows=3, cols=40,
                    placeholder="Enter correct answer here..."),
    	tags$textarea(id="hint", rows=3, cols=40, 
                    placeholder="Enter hint here..."),
    	tags$textarea(id="ans_tests", rows=3, cols=40, 
                    placeholder="Enter answer tests here...")
		),
    actionButton("finalSubmit", "I'm done!")
	)
))