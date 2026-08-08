#' kpi_card UI Function
#'
#' This module will create value box for key indicators of task analysis like total number of task with no due' dates etc.
#'
#'  @param id,input,output,session Internal parameters for {shiny}.
#'
#'  @importFrom shiny NS tagList
#'
#' @examples
#'
#' ui <- bs4Dash::dashboardPage(
#'   bs4Dash::dashboardHeader(),
#'   bs4Dash::dashboardSidebar(disable = TRUE),
#'   bs4Dash::dashboardBody(
#'     fluidRow(
#'       mod_kpi_card_ui("kpi_card_example")
#'     )
#'   )
#' )
#'
#' server <- function(input, output) {
#'   mod_kpi_card_server("kpi_card_example")
#' }
#' shiny::shinyApp(ui, server)
#'
mod_kpi_card_ui <- function(id) {
  ns <- NS(id)
  tagList(
    bs4Dash::valueBoxOutput(ns("kpi_card"), width = 12)
  )
}

#' kpi_card Server Functions
#' @inherit [components mod_kpi_card_ui()] @description
#'
#'
mod_kpi_card_server <- function(id, card_value, card_subtitle = NULL) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    output$kpi_card <- bs4Dash::renderValueBox(
      bs4Dash::valueBox(
        value = h3(card_value),
        subtitle = h6(card_subtitle),
        icon = NULL,
        width = NULL,
        color = "white",
        href = NULL
      )
    )
  })
}

## To be copied in the UI
# mod_kpi_card_ui("kpi_card_1")

## To be copied in the server
# mod_kpi_card_server("kpi_card_1")
