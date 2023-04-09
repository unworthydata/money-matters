# Get the current file's directory
current_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

# Set the working directory to the current directory
setwd(current_dir)

library(plotly)

# import dataset
df <- read.csv("data/GBD_Q2_DATA.csv")

# drop all columns except "location_name", "year", and "val"
df <- df[, c("location_name", "year", "val")]

accumulate_by <- function(dat, var) {
  var <- lazyeval::f_eval(var, dat)
  lvls <- plotly:::getLevels(var)
  dats <- lapply(seq_along(lvls), function(x) {
    dat_filtered <- dat[var %in% lvls[seq(1, x)], ]
    dat_filtered$val_cumulative <- cumsum(dat_filtered$val)
    cbind(dat_filtered, frame = lvls[[x]])
  })
  dplyr::bind_rows(dats)
}

# Call accumulate_by() on df to create df_anim with cumulative sum
df_anim <- df %>% accumulate_by(~year)

plot2 <- df_anim %>% plot_ly(x = ~year, frame=~frame ,y = ~val, color = ~location_name, 
                             hovertemplate = "%{y:.2%}",
                             type = "scatter", mode = "lines",
                             line = list(width = 3)) %>%
  layout(xaxis = list(title = "Year", color="#fff", gridwidth = 2),
         yaxis = list(title = "Value", color="#fff", gridwidth = 2),
         showlegend=FALSE,
         hoverlabel = list(namelength = -1, bgcolor="#616161"),
         font = list(family="Jetbrains Mono, Monospace", color="#fff"),
         paper_bgcolor="#000",
         plot_bgcolor="#000",
         hovermode = "x unified",
         title = list(text = "Rates of Global Mental Disorder Prevalence by Income",
                      font = list(size = 24)),
         yanchor="top",
         margin=50) %>%
  animation_opts(
    frame = 70, 
    transition = 0,
    redraw = FALSE
  )

# Display the plot
plot2
return(plot2)