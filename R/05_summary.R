summaryUI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 6,
        includeMarkdown("www/text/intro.Rmd")
      ),
      column(
        width = 6,
        # Add the image with a caption and hyperlink
        shiny::br(),
        tags$div(
          style = "text-align: center;",
          tags$img(src = "https://imgs.xkcd.com/comics/correlation_2x.png", alt = "xkcd comic", style = "max-width: 100%; height: auto;"),
          tags$figcaption(
            style = "font-size: 12px; color: #555;",
            "Image source: ",
            tags$a(href = "https://xkcd.com/552/", "https://xkcd.com", target = "_blank", rel = "noopener noreferrer")
          )
        ),
        includeMarkdown("www/text/intro2.Rmd")
      )
    )
  )
}



summaryServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
  })
}


utils::globalVariables(c("lm"))
