# Get the current file's directory
current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

# Set the working directory to the current directory
setwd(current_dir)

# Load required libraries
library(shiny)
library(plotly)

# Define UI
ui <- fluidPage(
  # App title and heading
  titlePanel("My Shiny App"),
  h1("My Plots"),
  
  # Four rows for each plot and explanation
  fluidRow(
    # Row 1: Explanation 1 and Plot 1
    column(
      width = 6,
      h3("Explanation 1"),
      p("This is an explanation for Plot 1.")
    ),
    column(
      width = 6,
      h3("Plot 1"),
      plotlyOutput("plot1")
    )
  ),
  
  fluidRow(
    # Row 2: Explanation 2 and Plot 2
    column(
      width = 6,
      h3("Explanation 2"),
      p("This is an explanation for Plot 2.")
    ),
    column(
      width = 6,
      h3("Plot 2"),
      plotlyOutput("plot2")
    )
  ),
  
  fluidRow(
    # Row 3: Explanation 3 and Plot 3
    column(
      width = 6,
      h3("Explanation 3"),
      p("This is an explanation for Plot 3.")
    ),
    column(
      width = 6,
      h3("Plot 3"),
      plotlyOutput("plot3")
    )
  ),
  
  fluidRow(
    # Row 4: Explanation 4 and Plot 4
    column(
      width = 6,
      h3("Explanation 4"),
      p("This is an explanation for Plot 4.")
    ),
    column(
      width = 6,
      h3("Plot 4"),
      plotlyOutput("plot4")
    )
  )
)

# Define Server
server <- function(input, output) {
  
  # Render Plotly plots
  output$plot1 <- renderPlotly({
    # Load and run Q1.R script, and assign the returned plot object to the plotlyOutput
    source("Q1.R", local = TRUE)$value
  })
  
  output$plot2 <- renderPlotly({
    # Load and run Q2.R script, and assign the returned plot object to the plotlyOutput
    source("Q2.R", local = TRUE)$value
  })
  
  output$plot3 <- renderPlotly({
    # Load and run Q3.R script, and assign the returned plot object to the plotlyOutput
    source("Q3.R", local = TRUE)$value
  })
  
  output$plot4 <- renderPlotly({
    # Load and run Q4.R script, and assign the returned plot object to the plotlyOutput
    source("Q4.R", local = TRUE)$value
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
