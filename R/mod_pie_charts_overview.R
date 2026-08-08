#' pie_charts_overview UI Function
#'
#' @description A shiny Module. right now not in use
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @note
#'
#' @importFrom shiny NS tagList
#' @examples
#' ui <- bs4Dash::dashboardPage(
#'   bs4Dash::dashboardHeader(),
#'   bs4Dash::dashboardSidebar(disable = TRUE),
#'   bs4Dash::dashboardBody(
#'     fluidRow(
#'       mod_pie_charts_overview_ui("pie_charts_example")
#'     )
#'   )
#' )
#' server <- function(input, output) {
#'   mod_pie_charts_overview_server("pie_charts_example")
#' }
#'
#' shiny::shinyApp(ui, server)
mod_pie_charts_overview_ui <- function(id) {
  ns <- NS(id)
  tagList(
    mod_pie_chart_ui(ns("task_completion_rate"), pie_chart_title = "Total Tasks Completion Rate %")
    # mod_pie_chart_ui(ns("task_completion_rate_by_taskgroups"), pie_chart_title = "Total Tasks Completion Rate % by Task Group")
  )
}

#' pie_charts_overview Server Functions
#'
#' @noRd
mod_pie_charts_overview_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # mod_pie_chart_server("task_completion_rate", pie_chart_values = task_completion_rate()$n, pie_chart_labels = task_completion_rate()$Completed)
  })
}

## To be copied in the UI
# mod_pie_charts_overview_ui("pie_charts_overview_1")

## To be copied in the server
# mod_pie_charts_overview_server("pie_charts_overview_1")
