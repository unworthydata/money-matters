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

# Convert country names to country codes
df$code <- countrycode(df$location_name, "country.name", "iso3c")

# Create choropleth map
plot1 <- plot_ly(df, locations = ~code, z = ~val, type = "choropleth",
               locationmode = "ISO-3", colorbar = list(title = "Value"),
               frame = ~year)

# Add title and annotations
plot1 <- plot1 %>% layout(title = "Choropleth Map",
                      annotations = list(x = 0.5, y = -0.1, 
                                         text = "Year", showarrow = FALSE,
                                         font = list(size = 14)))

# Show the plot
return(plot1)