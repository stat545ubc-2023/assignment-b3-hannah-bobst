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
}
shinyApp(ui = ui, server = server)