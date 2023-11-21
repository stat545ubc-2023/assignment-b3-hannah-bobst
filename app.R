# Load packages
library(shiny)
library(tidyverse)
library(palmerpenguins)

# Shiny app
ui <- fluidPage(
  h1("Exploring the palmerpenguins Dataset"),
  "This application explores the palmerpenguins dataset using various descriptive tools.",
  br(),
  h3("Boxplot"),
  "Using the drop-down menu, the user may specify which variable should be plotted for each penguin species. This drop-down menu ensures that only numerical variables are selected.",
  sidebarLayout(
    sidebarPanel(
      selectInput("plot_variable", "Choose a variable to be plotted: ", 
                  c("Bill Length (mm)" = "bill_length_mm", 
                    "Bill Depth (mm)" = "bill_depth_mm", 
                    "Flipper Length (mm)" = "flipper_length_mm", 
                    "Body Mass (g)" = "body_mass_g"))
    ), 
    mainPanel(
      plotOutput("boxplot")
    )
  ),
  br(),
  h3("Scatterplot by Year"), 
  "The user may select which variables to plot by species, as well as which year should be used. The drop-down menus ensure that only two numerical variables are selected. The silder ensures that only one of the three possible years are selected.",
  sidebarLayout(
    sidebarPanel(
      selectInput("s_plot_variable_one", "Choose first variable: ", 
                  c("Bill Length (mm)" = "bill_length_mm", 
                    "Bill Depth (mm)" = "bill_depth_mm", 
                    "Flipper Length (mm)" = "flipper_length_mm", 
                    "Body Mass (g)" = "body_mass_g")),
      selectInput("s_plot_variable_two", "Choose second variable: ", 
                  c("Bill Depth (mm)" = "bill_depth_mm", 
                    "Bill Length (mm)" = "bill_length_mm",
                    "Flipper Length (mm)" = "flipper_length_mm", 
                    "Body Mass (g)" = "body_mass_g")), 
      sliderInput("num", "Choose a year: ",
                  min = 2007, max = 2009, value = 2008)
    ),
    mainPanel(
      plotOutput("s_plot")
    )
  ), 
  br(), 
  h3("Summary Table of Means"), 
  "The summary table below shows the means of the numerical variables grouped by species. The user may specify whether to also group by sex. The single checkbox ensures that only one of True or False is always selected. Note that in both cases, NA values in the numerical varaibles are dropped. Also, note that when True is selected, NA values in the sex variable are dropped. ", 
  sidebarLayout(
    sidebarPanel(
      checkboxInput("check_value", "Group by sex", FALSE)
    ), 
    mainPanel(
      tableOutput("mean_table")
    )
  )
)
server <- function(input, output) {
  output$boxplot <- renderPlot({
    penguins %>% 
      group_by("species") %>%
      ggplot(aes_string("species", y = input$plot_variable, fill = "species")) + 
      geom_boxplot() + 
      ggtitle("Boxplot of Selected Variable by Species")
  })
  output$s_plot <- renderPlot({
    penguins %>%
      filter(year==input$num) %>%
      group_by("species") %>%
      ggplot(aes_string(x = input$s_plot_variable_one, y = input$s_plot_variable_two, colour="species")) + 
      geom_point() + 
      ggtitle("Scatterplot by Selected Year and Variables")
  })
  output$mean_table <- renderTable({
    if(input$check_value == TRUE){
      penguins %>%
        group_by(species, sex) %>%
        drop_na(sex) %>%
        summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE), 
                  mean_bill_depth = mean(bill_depth_mm, na.rm = TRUE), 
                  mean_flipper_length = mean(flipper_length_mm, na.rm=TRUE), 
                  mean_body_mass = mean(body_mass_g, na.rm = TRUE))
    } else{
      penguins %>%
        group_by(species) %>%
        summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE), 
                  mean_bill_depth = mean(bill_depth_mm, na.rm = TRUE), 
                  mean_flipper_length = mean(flipper_length_mm, na.rm=TRUE), 
                  mean_body_mass = mean(body_mass_g, na.rm = TRUE))
    }
  })
}
shinyApp(ui = ui, server = server)