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
mod_kpi_card_overview_ui <- function(id) {
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
      # shiny::column(
      #   3,
      #   # Total no. of tasks not completed but overall status marked as completed kpi card UI------
      #   mod_kpi_card_ui(ns("not_complete_marked_as_completed"))
      # ),
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
      # shiny::column(
      #   3,
      #   # total no. of output files kpi card UI-----
      #   mod_kpi_card_ui(ns("output_files"))
      # ),
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
mod_kpi_card_overview_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # Total number of tasks with no due date kpi card Server --------
    mod_kpi_card_server("No_due_date",
      card_value = due_date_count(),
      card_subtitle = "Task with Missing Due Dates"
    )
    # Total no. of tasks overdue and not completed as of today kpi card Server -----
    mod_kpi_card_server("overdue_and_not_completed",
      card_value = overdue_and_not_completed(),
      card_subtitle = "Overdue Tasks"
    )

    # Total no. of tasks not completed but overall status marked as completed kpi card Server ------
    # mod_kpi_card_server("not_complete_marked_as_completed",
    #   card_value = not_completed_and_status_completed(),
    #   card_subtitle = "Total #Task  marked as Completed but Overall Status marked as completed"
    # )

    # total no. of upcoming tasks kpi card Server ----
    mod_kpi_card_server("upcomming_task",
      card_value = upcomming_task_count(),
      card_subtitle = "Upcoming Tasks"
    )

    # Total no. of programs kpi card Server -----
    mod_kpi_card_server("programs",
      card_value = program_count(),
      card_subtitle = "Programs Executed"
    )
    # total no. of output files kpi card Server-----
    # mod_kpi_card_server("output_files",
    #   card_value = output_files_count(),
    #   card_subtitle = "Total # Output Files"
    # )

    # total no. of tasks updated in last 24 hrs kpi card Server ----
    mod_kpi_card_server("updated_within_24hrs",
      card_value = task_updated_within_24hr_count(),
      card_subtitle = "Tasks in Progress"
    )

    # total no. of open issues kpi card Server ----
    mod_kpi_card_server("open_issues",
      card_value = open_issues_count(),
      card_subtitle = "Open Issues"
    )
  })
}

## To be copied in the UI
# mod_kpi_card_overview_ui("kpi_card_overview_1")

## To be copied in the server
# mod_kpi_card_overview_server("kpi_card_overview_1")
