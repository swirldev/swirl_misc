library(shiny)

shinyUI(pageWithSidebar(
  
  # Lesson name will go here
  headerPanel("Lesson Name Here"),
  
  # Select unit class
  sidebarPanel(
    # Select unit class
    selectInput("class", "Unit class:",
                choices = c("Text" = "text", 
                            "Question - R Command" = "cmd_question",
                            "Question - Multiple Choice" = "mult_question",
                            "Question - Exact Numerical" = "exact_question",
                            "Video" = "video", 
                            "Figure" = "figure")
                )
    ),
  
  # Display appropriate form based on unit class
  mainPanel(
    
    # Output current unit class selected for testing purposes
		verbatimTextOutput("unitClass"),
    
    # Text form
    conditionalPanel(
      condition = "input.class == 'text'",
      tags$textarea(id="text_output", rows=3, cols=40, 
                    placeholder="Text")
      ),
    
    # Command question form
  	conditionalPanel(
    	condition = "input.class == 'cmd_question'",
    	tags$textarea(id="cmd_output", rows=3, cols=40, 
    	              placeholder="Question"),
    	tags$textarea(id="cmd_correct_answer", rows=3, cols=40,
                    placeholder="Correct answer"),
    	tags$textarea(id="cmd_answer_tests", rows=3, cols=40, 
                    placeholder="Answer tests (separated by semi-colons)"),
    	tags$textarea(id="cmd_hint", rows=3, cols=40, 
    	              placeholder="Hint")
      ),
    
		# Multiple choice question form
		conditionalPanel(
		  condition = "input.class == 'mult_question'",
		  tags$textarea(id="mult_output", rows=3, cols=40, 
		                placeholder="Question"),
		  tags$textarea(id="mult_answer_choices", rows=3, cols=40,
		                placeholder="Correct answer"),
		  tags$textarea(id="mult_correct_answer", rows=3, cols=40,
		                placeholder="Answer tests (separated by semi-colons)"),
		  tags$textarea(id="mult_hint", rows=3, cols=40, 
		                placeholder="Hint")
      ),
    
		# Numeric question
		conditionalPanel(
		  condition = "input.class == 'exact_question'",
		  tags$textarea(id="num_output", rows=3, cols=40, 
		                placeholder="Question"),
		  tags$textarea(id="num_correct_answer", rows=3, cols=40,
		                placeholder="Correct answer"),
		  tags$textarea(id="num_hint", rows=3, cols=40, 
		                placeholder="Hint")
      ),
    
    # Video form
		conditionalPanel(
		  condition = "input.class == 'video'",
		  tags$textarea(id="video_output", rows=3, cols=40, 
		                placeholder="Would you like to watch a video on..."),
		  tags$textarea(id="video_link", rows=3, cols=40, 
		                placeholder="Video URL")
      ),
    
    # Figure form
		conditionalPanel(
		  condition = "input.class == 'figure'",
		  tags$textarea(id="fig_output", rows=3, cols=40, 
		                placeholder="Text"),
		  tags$textarea(id="figure", rows=3, cols=40, 
		                placeholder="Figure file name (.R extension)"),
		  tags$textarea(id="figure_type", rows=3, cols=40, 
		                placeholder="new or add?")
      ),
    
    # Action button for when form is complete
    actionButton("finalSubmit", "I'm done!")
    )
))