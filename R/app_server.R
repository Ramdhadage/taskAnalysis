#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # All KPI Cards ----
  mod_kpi_card_overview_dummy_server("kpi_cards")
  mod_pie_chart_server("task_completion_rate", pie_chart_values = task_completion_rate()$n, pie_chart_labels = task_completion_rate()$Completed)
  # mod_pie_charts_overview_server("pie_chart")
  mod_bar_chart_server("total_completion_rate_by_study", bar_chart_values = task_completion_rate_by_taskgroup()$n, bar_chart_labels = task_completion_rate_by_taskgroup()$Task.Group)
  mod_bar_chart_server("bar_chart")
  mod_area_chart_server("area_chart")
}
