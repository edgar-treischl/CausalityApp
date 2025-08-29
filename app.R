library(shiny)
library(patchwork)


#Source depending on ...
get_script_path <- function(filename) {
  if (file.exists(file.path("R", filename))) {
    file.path("R", filename)  # Development mode
  } else {
    filename  # Deployment (flat structure)
  }
}



modules <- c(
  "00_scatter_plot.R",
  "01_intro.R",
  "02_shoesize_plot.R",
  "03_mediator_plot.R",
  "04_collider_plot.R",
  "05_summary.R",
  "utils.R"
)

lapply(modules, function(f) source(get_script_path(f)))




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

