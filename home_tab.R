
homeTabUI <- function(id, tabName) {
  ns <- NS(id)
  tabItem(
    tabName = tabName,
    h1("Welcome to RichStudio v0.1.4."),
    p("Upload from differential expression geneset (DEG) or enrichment result. Supports kappa clustering and multiple visualizations."),
    br(),
    fluidRow(
      box(
        width = 12, status = "info", solidHeader = TRUE,
        title = tagList(shiny::icon("info-circle"), "Note"),
        p("This web application is functional, but some features are still under development and may not work fully as expected."),
        p("You can follow updates or report issues on GitHub:"),
        tags$p(
          tags$a(
            href = "https://github.com/hurlab/richStudio",
            target = "_blank",
            shiny::icon("github"),
            " hurlab/richStudio"
          )
        ),
        tags$p(
          tags$a(
            href = "http://hurlab.med.und.edu:3838/richStudio_3/",
            target = "_blank",
            "richStudio v0.1.5 (test version)"
          )
        )
      )
    )
  )
}

homeTabServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # No server logic needed here
  })
}
