# # Get the current file's directory
# current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
# 
# # Set the working directory to the current directory
# setwd(current_dir)

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

      /* Set width of the columns */
      .left-column, .right-column {
        padding: 10dp;
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
          width = 4,
          h3("1. What is the prevalence of mental disorders globally over time?"),
          p("This choropleth plot shows the rates of mental disorder prevalence over time, with a play button to animate these changes. The values do not change much, so changes may be hard to see. There is also a slider so you can select an individual year."),
          p("One observation that stands out is the stark difference between Iran and all of the other countries in the map. They have much higher rates of mental disorders. Australia is a close second, sticking out almost as much."),
          p("A comforting fact is that mental disorder rates have not risen, and have actually fallen in some countries, even if it seems like everyone is depressed these days. One hypothesis is that it could be due to the fact that social media blows things out of proportion, and it has become somewhat \"cool\" to claim to be battling mental issues.")
        ),
        column(
          width = 8,
          plotlyOutput("plot1", height="80vh")
        )
      )
    ),
    
    # Tab 2: Plot 2 and Explanation 2
    tabPanel(
      "Question 2",
      fluidRow(
        column(
          width = 4,
          h3("2. What is the relationship between income level and prevalence of mental disorders globally over time?"),
          p("This plot shows the trend in the prevalence of mental health disorders over time, split by income levels as classified by the World Bank (Low, Lower Middle, Upper Middle, High)."),
          p("It appears that income level and the prevalence of mental disorders are directly related, with a person being more likely to have mental issues the more income they have. It could also be attributed to the simple fact that richer people have more access to healthcare, and are thus diagnosed at higher rates compared to people with lower income.")
        ),
        column(
          width = 8,
          plotlyOutput("plot2", height="80vh")
        )
      )
    ),
    
    # Tab 3: Plot 3 and Explanation 3
    tabPanel(
      "Question 3",
      fluidRow(
        column(
          width = 4,
          h3("3. How does the prevalence of specific mental disorders, such as depression or anxiety, differ by income level?"),
          p("This stacked bar graph shows the prevalence of mental disorders, grouped by World Bank income levels, and split by specific mental disorders. The bars are of different heights because the different groups see different levels of mental disorder prevalence."),
          p("You can click on individual mental illnesses to filter them in or out and get a clearer picture.")
        ),
        column(
          width = 8,
          plotlyOutput("plot3", height="80vh")
        )
      )
    ),
    
    # Tab 4: Plot 4 and Explanation 4
    tabPanel(
      "Question 4",
      fluidRow(
        column(
          width = 4,
          h3("4. What is the relative difference between income level and prevalence of mental disorders globally over time?"),
          p("This stacked bar graph shows the prevalence of mental disorders, grouped by World Bank income levels, and split by specific mental disorders. This is similar to the previous graph, but it is normalized so we can see the relative differences in the prevalence of specific mental disorders across these income groups."),
          p("A noticeable difference is seen in the rates of anxiety disorders, where the Lower Middle group seems to have the lowest rates of anxiety. The High income group has much higher rates of eating disorders and substance use disorders, probably because they have more disposable income to buy drugs of abuse."),
          p("You can click on individual mental illnesses to filter them in or out and get a clearer picture.")
        ),
        column(
          width = 8,
          plotlyOutput("plot4", height="80vh")
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
