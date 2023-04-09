# # Get the current file's directory
# current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
# 
# # Set the working directory to the current directory
# setwd(current_dir)

library(plotly)
library(viridis)

# Import dataset
df <- read.csv("data/GBD_Q1_DATA.csv")

# Remove columns except for "location_name", "year", and "val"
df <- df[, c("location_name", "year", "val")]

# Create choropleth map
plot1 <- plot_ly(df, locations = ~location_name, z = ~val, type = "choropleth",
                 locationmode = "country names",
                 colorbar = list(title = list(text = "Value", font= list(size = 14)),
                                 tickformat = ".1%", # Set colorbar tickformat to ".1%"
                                 len = 0.7,
                                 yanchor="center"), 
                 frame = ~year,
                 # formatting hover text
                 hovertemplate = "%{location}<br>%{z:.1%}",
                 # to remove excess text (trace0)
                 hoverlabel = list(namelength=0, 
                                   font = list(family = "Jetbrains Mono, Monospace")))

# Add title and annotations with JetBrains Mono font
plot1 <- plot1 %>% layout(
  font = list(family = "Jetbrains Mono, Monospace", color="#fff"),
  title = list(text = "Rates of Global Mental Disorder Prevalence over time",
               font = list(size = 24)),
  yanchor="top",
  margin=50
)

plot1 <- plot1 %>%
  layout(paper_bgcolor="#000", plot_bgcolor="#000")
# Show the plot
plot1
return(plot1)