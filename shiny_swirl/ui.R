library(shiny)

shinyUI(pageWithSidebar(
  
  # Lesson name will go here
  headerPanel("Lesson Name Here"),
  
  # Select unit class
  sidebarPanel(
    # Select unit class
    selectInput("class", "Unit class:",
                choices = c("Text", 
                            "Question - R Command",
                            "Question - Multiple Choice",
                            "Question - Numeric",
                            "Question - Text",
                            "Video", 
                            "Figure")
                )
    ),
  
  # Display appropriate form based on unit class
  mainPanel(
    
    # Output current unit class selected for testing purposes
		verbatimTextOutput("unitClass"),
    
    # Text form
    conditionalPanel(
      condition = "input.class == 'Text'",
      tags$textarea(id="output", rows=3, cols=40, 
                    placeholder="Enter main text here...")
      ),
    
    # Command question form
  	conditionalPanel(
    	condition = "input.class == 'Question - R Command'",
    	tags$textarea(id="output", rows=3, cols=40, 
    	              placeholder="Enter main text here..."),
    	tags$textarea(id="correct_answer", rows=3, cols=40,
                    placeholder="Enter correct answer here..."),
    	tags$textarea(id="answer_tests", rows=3, cols=40, 
                    placeholder="Enter answer tests here..."),
    	tags$textarea(id="hint", rows=3, cols=40, 
    	              placeholder="Enter hint here...")
      ),
    
		# Multiple choice question form
		conditionalPanel(
		  condition = "input.class == 'Question - Multiple Choice'",
		  tags$textarea(id="output", rows=3, cols=40, 
		                placeholder="Enter main text here..."),
		  tags$textarea(id="answer_choices", rows=3, cols=40,
		                placeholder="Enter answer choices here..."),
		  tags$textarea(id="correct_answer", rows=3, cols=40,
		                placeholder="Enter correct answer here..."),
		  tags$textarea(id="hint", rows=3, cols=40, 
		                placeholder="Enter hint here...")
      ),
    
		# Numeric question
		conditionalPanel(
		  condition = "input.class == 'Question - Numeric'",
		  tags$textarea(id="output", rows=3, cols=40, 
		                placeholder="Enter main text here..."),
		  tags$textarea(id="correct_answer", rows=3, cols=40,
		                placeholder="Enter correct answer here..."),
		  tags$textarea(id="hint", rows=3, cols=40, 
		                placeholder="Enter hint here...")
      ),
    
    # Text question
		conditionalPanel(
		  condition = "input.class == 'Question - Text'",
		  tags$textarea(id="output", rows=3, cols=40, 
		                placeholder="Enter main text here..."),
		  tags$textarea(id="correct_answer", rows=3, cols=40,
		                placeholder="Enter correct answer here..."),
		  tags$textarea(id="hint", rows=3, cols=40, 
		                placeholder="Enter hint here...")
      ),
    
    # Video form
		conditionalPanel(
		  condition = "input.class == 'Video'",
		  tags$textarea(id="output", rows=3, cols=40, 
		                placeholder="Enter main text here..."),
		  tags$textarea(id="video_link", rows=3, cols=40, 
		                placeholder="Enter video URL here...")
      ),
    
    # Figure form
		conditionalPanel(
		  condition = "input.class == 'Figure'",
		  tags$textarea(id="output", rows=3, cols=40, 
		                placeholder="Enter main text here..."),
		  tags$textarea(id="figure", rows=3, cols=40, 
		                placeholder="Enter figure filename here..."),
		  tags$textarea(id="figure_type", rows=3, cols=40, 
		                placeholder="Enter figure type here...")
      ),
    
    # Action button for when form is complete
    actionButton("finalSubmit", "I'm done!")
    )
))