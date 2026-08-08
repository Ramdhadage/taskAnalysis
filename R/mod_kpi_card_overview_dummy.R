#' kpi_card_overview UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#'
#' @importFrom shiny NS tagList
#' @examples
#' ui <- bs4Dash::dashboardPage(
#'   bs4Dash::dashboardHeader(),
#'   bs4Dash::dashboardSidebar(disable = TRUE),
#'   bs4Dash::dashboardBody(
#'     fluidRow(
#'       mod_kpi_card_overview_ui("kpi_card_example")
#'     )
#'   )
#' )
#' server <- function(input, output) {
#'   mod_kpi_card_overview_server("kpi_card_example")
#' }
#'
#' shiny::shinyApp(ui, server)
#'
mod_kpi_card_overview_dummy_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shiny::fluidRow(
      shiny::column(
        3,
        # Total number of tasks with no due date kpi card UI --------
        mod_kpi_card_ui(ns("No_due_date"))
      ),
      shiny::column(
        3,
        # Total no. of tasks overdue and not completed as of today kpi card UI -----
        mod_kpi_card_ui(ns("overdue_and_not_completed"))
      ),
      shiny::column(
        3,
        # Total no. of tasks not completed but overall status marked as completed kpi card UI------
        mod_kpi_card_ui(ns("not_complete_marked_as_completed"))
      ),
      shiny::column(
        3,
        # # total no. of upcoming tasks kpi card UI ----
        mod_kpi_card_ui(ns("upcomming_task"))
      ),
      shiny::column(
        3,
        # Total no. of programs kpi card UI -----
        mod_kpi_card_ui(ns("programs"))
      ),
      shiny::column(
        3,
        # total no. of output files kpi card UI-----
        mod_kpi_card_ui(ns("output_files"))
      ),
      shiny::column(
        3,
        # total no. of tasks updated in last 24 hrs kpi card UI ----
        mod_kpi_card_ui(ns("updated_within_24hrs"))
      ),
      shiny::column(
        3,
        # total no. of open issues kpi card UI ----
        div(mod_kpi_card_ui(ns("open_issues")))
      )
    )
  )
}

#' kpi_card_overview Server Functions
#'
#' @noRd
mod_kpi_card_overview_dummy_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # Total number of tasks with no due date kpi card Server --------
    mod_kpi_card_server("No_due_date",
                        card_value = 30,
                        card_subtitle = "SDTM datasets generated"
    )
    # Total no. of tasks overdue and not completed as of today kpi card Server -----
    mod_kpi_card_server("overdue_and_not_completed",
                        card_value = 35,
                        card_subtitle = "Adam datasets generated"
    )
    # total no. of open issues kpi card Server ----
    mod_kpi_card_server("open_issues",
                        card_value = 16,
                        card_subtitle = "Outputs completed"
    )
    # total no. of upcoming tasks kpi card Server ----
    mod_kpi_card_server("upcomming_task",
                        card_value = 6,
                        card_subtitle = "Outputs not yet Started"
    )
    # Total no. of tasks not completed but overall status marked as completed kpi card Server ------
    mod_kpi_card_server("not_complete_marked_as_completed",
      card_value = 80,
      card_subtitle = "Outputs under development"
    )



    # Total no. of programs kpi card Server -----
    mod_kpi_card_server("programs",
                        card_value = 8,
                        card_subtitle = "Overdue tasks"
    )
    # total no. of output files kpi card Server-----
    mod_kpi_card_server("output_files",
      card_value = 15,
      card_subtitle = "Upcoming Tasks"
    )

    # total no. of tasks updated in last 24 hrs kpi card Server ----
    mod_kpi_card_server("updated_within_24hrs",
                        card_value = 16,
                        card_subtitle = "Planned vs Actual Program file name mismatch"
    )


  })
}

## To be copied in the UI
# mod_kpi_card_overview_ui("kpi_card_overview_1")

## To be copied in the server
# mod_kpi_card_overview_server("kpi_card_overview_1")
