# Get the current file's directory
current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

# Set the working directory to the current directory
setwd(current_dir)

# Load required libraries
library(shiny)
library(plotly)

# Define UI
ui <- fluidPage(
  # Set the background color to black and text color to white
  tags$head(
    tags$style(HTML("
      body {
        background-color: black;
        color: white;
      }

      .nav-pills > li > a {
        background-color: #222;
        color: white;
      }

      .nav-pills > li.active > a {
        background-color: #333;
      }

      /* Set font size and font family */
      h5, h1, h3, p {
        font-family: 'JetBrains Mono', monospace;
      }
      
      .plotly {
        margin: 5dp;
      }

      /* Set width of the columns */
      .left-column, .right-column {
        padding: 10dp;
      }

      .left-column {
        width: 40%;
      }

      .right-column {
        width: 60%;
      }
    "))
  ),
  
  # App title and heading
  h5("Omar Ismail (20311657) - Fundamentals of Information Visualization UNMC 22/23"),
  h1("Money Matters: How Socioeconomic Status Impacts Mental Health"),
  
  # Tabs
  tabsetPanel(
    # Tab 1: Plot 1 and Explanation 1
    tabPanel(
      "Question 1",
      fluidRow(
        column(
          width = 5,
          class = "left-column",
          h3("1. What is the prevalence of mental disorders globally over time?"),
          p("paragraph")
        ),
        column(
          width = 7,
          class = "right-column",
          plotlyOutput("plot1", height = "200%")
        )
      )
    ),
    
    # Tab 2: Plot 2 and Explanation 2
    tabPanel(
      "Question 2",
      fluidRow(
        column(
          width = 5,
          class = "left-column",
          h3("2. What is the relationship between income level and prevalence of mental disorders globally over time?"),
          p("paragraph")
        ),
        column(
          width = 7,
          class = "right-column",
          plotlyOutput("plot2")
        )
      )
    ),
    
    # Tab 3: Plot 3 and Explanation 3
    tabPanel(
      "Question 3",
      fluidRow(
        column(
          width = 5,
          class = "left-column",
          h3("3. How does the prevalence of specific mental disorders, such as depression or anxiety, differ by income level?"),
          p("paragraph")
        ),
        column(
          width = 7,
          class = "right-column",
          plotlyOutput("plot3")
        )
      )
    ),
    
    # Tab 4: Plot 4 and Explanation 4
    tabPanel(
      "Question 4",
      fluidRow(
        column(
          width = 5,
          class = "left-column",
          h3("4. What is the relative difference between income level and prevalence of mental disorders globally over time?"),
          p("paragraph")
        ),
        column(
          width = 7,
          class = "right-column",
          plotlyOutput("plot4")
        )
      )
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
