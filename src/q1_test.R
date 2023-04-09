# Get the current file's directory
current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

# Set the working directory to the current directory
setwd(current_dir)

library(plotly)
library(countrycode)

# Import dataset
df <- read.csv("data/GBD_Q1_DATA.csv")

# Remove columns except for "location_name", "year", and "val"
df <- df[, c("location_name", "year", "val")]

# Create choropleth map
plot1 <- plot_ly(df, locations = ~location_name, z = ~val, type = "choropleth",
                 locationmode = "country names", 
                 colorbar = list(title = list(text = "Value",
                                              font = list(family = "JetBrains Mono", size = 14)),
                                 tickformat = ".1%", # Set colorbar tickformat to ".1%"
                                 len = 0.7), 
                 frame = ~year,
                 hovertemplate = "%{location}<br>%{z:.1%}",
                 hoverlabel = list(namelength=0))

# Add title and annotations with JetBrains Mono font
plot1 <- plot1 %>% layout(
  title = list(text = "Rates of Global Mental Disorder Prevalence over time",
               font = list(family = "JetBrains Mono", size = 24),
               margin = list(t = 50)), # Set top margin of 50 pixels
  annotations = list(
    x = 0.5, y = -0.1,
    text = "Year", showarrow = FALSE,
    font = list(family = "JetBrains Mono", size = 14)
  )
)

# Show the plot
plot1
return(plot1)