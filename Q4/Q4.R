# Get the current file's directory
current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

# Set the working directory to the current directory
setwd(current_dir)

library(plotly)

# Import dataset
data <- read_csv("GBD_Q4_DATA.csv")

# Select columns to keep
data <- data %>% select(location, cause, year, val)

p <- ggplot(data, aes(fill=cause, y=val, x=location, frame=year)) + 
  geom_bar(position="stack", stat="identity")
