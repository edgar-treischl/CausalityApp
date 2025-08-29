library(shiny)
library(patchwork)

source("00_scatter_plot.R")
source("01_intro.R")
source("02_shoesize_plot.R")
source("03_mediator_plot.R")
source("04_collider_plot.R")
source("05_summary.R")
source("utils.R")



ui <- fixedPage(
  theme = bslib::bs_theme(bootswatch = "journal"),
  #theme = material,
  tags$style(
    "@import url('https://fonts.googleapis.com/css?family=EB+Garamond');
    * {
      font-family: EB Garamond;
    }
    .checkbox{
    font-size: larger;
    }
    p {
      color: black;
      font-size:120%;
    }"
  ),
  # Application title
  titlePanel("Power Analysis"),

  # Sidebar with a slider input for number of bins
  navbarPage("Causality", collapsible = TRUE,
             tabPanel("Summary", icon = icon("dove"),
                      summaryUI("summary")
             ),
             tabPanel("Start", icon = icon("play"),
                      scatterplotUI("scatter")
             ),
             tabPanel("Simulation", icon = icon("robot"),
                      introUI("histogram")
             ),
             tabPanel("Shoe Size and Income", icon = icon("shoe-prints"),
                      shoesizeUI("shoes")
             ),
             tabPanel("Mediator", icon = icon("medium-m"),
                      mediatorplotUI("mediator")
             ),
             tabPanel("Collider", icon = icon("cuttlefish"),
                      colliderplotUI("collider")
             )
  )
)


server <- function(input, output, session) {
  summaryServer("summary")
  scatterplotServer("scatter")
  introServer("histogram")
  shoesizeServer("shoes")
  mediatorplotServer("mediator")
  colliderplotServer("collider")

  
  
}


shinyApp(ui = ui, server = server)

