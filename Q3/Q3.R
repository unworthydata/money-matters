# Get the current file's directory
current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

# Set the working directory to the current directory
setwd(current_dir)

library(shiny)
library(dplyr)
library(plotly)
library(countrycode)

# Import GBD dataset and filter columns
gbd_data <- read.csv("GBD_dataset.csv") %>% 
  select(location_name, year, val)

# Import ILO dataset and filter columns
ilo_data <- read.csv("ILO_dataset.csv") %>% 
  slice(5:n()) %>% 
  select(`Country Name`, `Country Code`, `1991`:`2019`)

# Convert country names to ISO3C codes in GBD dataset
gbd_data$`Country Code` <- countrycode(sourcevar = gbd_data$location_name, origin = "country.name", destination = "iso3c")

# Join datasets
joined_data <- inner_join(gbd_data, ilo_data, by = c("Country Code" = "Country Code"))

# UI
ui <- fluidPage(
  titlePanel("Mental Disorder Stats and Unemployment Stats"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "country", label = "Select a country:", choices = sort(unique(joined_data$`Country Name`)), multiple = TRUE)
    ),
    mainPanel(
      plotlyOutput(outputId = "scatter_plot")
    )
  )
)

# Server
server <- function(input, output) {
  
  # Filter data based on selected countries
  filtered_data <- reactive({
    if (is.null(input$country)) {
      joined_data
    } else {
      joined_data %>% filter(`Country Name` %in% input$country)
    }
  })
  
  # Create scatter plot
  output$scatter_plot <- renderPlotly({
    plot <- plot_ly(data = filtered_data(), x = ~year, y = ~val, color = ~`Country Name`, type = "scatter", mode = "lines", hoverinfo = "text",
                    text = ~paste(`Country Name`, "<br>Year: ", year, "<br>Value: ", val),
                    line = list(width = 1)) %>%
      layout(xaxis = list(title = "Year", range = c(1991, 2019)),
             yaxis = list(title = "Value"),
             title = list(text = "Scatter Plot of Mental Disorder Stats and Unemployment Stats over Time"),
             updatemenus = list(list(type = "buttons",
                                     showactive = FALSE,
                                     buttons = list(list(label = "Play",
                                                         method = "animate",
                                                         args = list(list(frame = list(duration = 100, redraw = FALSE),
                                                                          fromcurrent = TRUE,
                                                                          transition = list(duration = 0))))))
             ))
    animation_opts = list(duration = 1000, easing = "linear")
  return(plot)
  })
}

# Run the app
shinyApp(ui = ui, server = server)
