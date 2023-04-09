# Load required libraries
library(shiny)
library(plotly)

# Define UI
ui <- fluidPage(
  # Set the background color to black and text color to white
  tags$head(tags$style(
    HTML(
      "
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

      /* Set width of the columns */
      .left-column, .right-column {
        padding: 10dp;
      }
    "
    )
  )),
  
  # App title and heading
  h5(
    "Omar Ismail (20311657) - Fundamentals of Information Visualization UNMC 22/23"
  ),
  h1("Money Matters: How Socioeconomic Status Impacts Mental Health"),
  
  # Tabs
  tabsetPanel(# Tab 1: Plot 1 and Explanation 1
    tabPanel("Question 1",
             fluidRow(
               column(
                 width = 4,
                 h3("1. What is the prevalence of mental disorders globally over time?")
               ),
               column(width = 8,
                      plotlyOutput("plot1", height="80vh"))
             )))
)


# Define Server
server <- function(input, output) {
  # Render Plotly plots
  output$plot1 <- renderPlotly({
    # Load and run Q1.R script, and assign the returned plot object to the plotlyOutput
    source("Q1.R", local = TRUE)$value
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)