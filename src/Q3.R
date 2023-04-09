# Get the current file's directory
current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

# Set the working directory to the current directory
setwd(current_dir)

# Load required libraries
library(plotly)
library(dplyr)
library(viridis)

# Import dataset
data <- read.csv("data/GBD_Q3_DATA.csv")

# Rename "location" column to "income"
data <- data %>% rename(income = location)

# Specify order of income levels
income_order <- c("World Bank Low Income", "World Bank Lower Middle Income", 
                  "World Bank Upper Middle Income", "World Bank High Income")

# Convert income to factor with specified order
data$income <- factor(data$income, levels = income_order)

# Select columns to keep
data <- data %>% select(income, cause, year, val)

my_palette <- turbo(11)

# Sort data by val in descending order
data <- data %>% arrange(desc(val))

# Reorder levels of cause variable
data$cause <- factor(data$cause, levels = unique(data$cause))

# Create a clustered stacked bar chart with animation
plot3 <- data %>% 
  plot_ly(x = ~income, y = ~val, color = ~cause, colors = my_palette, type = "bar", 
          split = ~cause, groupnorm = "percent") %>%
  layout(title = list(text = "Prevalence of Global Mental Disorders by Income Level",
                      font = list(size = 24)),
         yaxis = list(title = "Prevalence (%)"),
         xaxis = list(title = "Income Level"),
         font=list(family = "Jetbrains Mono, Monospace",
                   color="#fff"),
         barmode = "stack",
         paper_bgcolor="#000",
         plot_bgcolor="#000",
         yanchor="top",
         margin=50)

plot3
# Show plot
return(plot3)