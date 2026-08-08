#' pie_chart UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#'
#' @importFrom shiny NS tagList
#'
#' @examples
#' ui <- bs4Dash::dashboardPage(
#'   bs4Dash::dashboardHeader(),
#'   bs4Dash::dashboardSidebar(disable = TRUE),
#'   bs4Dash::dashboardBody(
#'     fluidRow(
#'       mod_pie_chart_ui("pie_chart_example", pie_chart_title = "Pie Chart")
#'     )
#'   )
#' )
#' server <- function(input, output) {
#'   mod_pie_chart_server("pie_chart_example", pie_chart_values = task_completion_rate()$n, pie_chart_labels = task_completion_rate()$Completed)
#' }
#'
#' shiny::shinyApp(ui, server)
#'
mod_pie_chart_ui <- function(id, pie_chart_title) {
  ns <- NS(id)
  tagList(
    shinyjs::useShinyjs(),
    bs4Dash::box(
      id = ns("pie_chart_box"),
      div(plotly::plotlyOutput(ns("pie_chart")),id = "pie_charts"),
      title = pie_chart_title,
      status = "info",
      width = 12, maximizable = TRUE
    )
  )
}

#' pie_chart Server Functions
#'
#' @noRd
mod_pie_chart_server <- function(id, pie_chart_values = task_completion_rate()$n, pie_chart_labels = task_completion_rate()$Completed) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    output$pie_chart <- plotly::renderPlotly({
      plotly::plot_ly(labels = pie_chart_labels, values = pie_chart_values, type = "pie", textinfo= "text", text=paste0(pie_chart_values,"(",round(pie_chart_values/sum(pie_chart_values)*100,2),"%)"), textposition = "outside")|>
        plotly::style(hoverinfo = "none")



    })
    # box_id = "pie_chart_box"
    # plot_name = "pie_chart"
    # non_max_height = "400px"
    # shiny::observeEvent(input[[box_id]]$maximized,{
    #   browser()
    #   print("plot maximized")
    # },ignoreInit = TRUE)
    add_plot_maximize_observer(input, "pie_chart_box", "pie_charts")
  })
}

## To be copied in the UI
# mod_pie_chart_ui("pie_chart_1")

## To be copied in the server
# mod_pie_chart_server("pie_chart_1")
