# Get the current file's directory
current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

# Set the working directory to the current directory
setwd(current_dir)

library(plotly)

# import dataset
df <- read.csv("IHME-GBD_2019_DATA-992cec3a-1.csv")

# drop all columns except "location_name", "year", and "val"
df <- df[, c("location_name", "year", "val")]

# create plotly figure
fig <- plot_ly(df, x = ~year, y = ~val, color = ~location_name, type = "scatter", mode = "lines") %>%
  layout(xaxis = list(title = "Year"),
         yaxis = list(title = "Value"))


# display plotly figure
fig
