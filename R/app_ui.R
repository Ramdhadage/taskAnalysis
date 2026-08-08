#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    golem_add_external_resources(),
    bs4Dash::dashboardPage(
      # preloader = list(html = tagList(waiter::spin_1(), "Loading ..."), color = "#3c8dbc"),
      bs4Dash::dashboardHeader(
        title = "Operational Dashboard"),
      bs4Dash::dashboardSidebar(
        bs4Dash::sidebarMenu(
          bs4Dash::menuItem("Tasks",tabName = "Tasks"),
          bs4Dash::menuItem("Studies", tabName = "Studies"),
          bs4Dash::menuItem("Users & Roles",tabName = "Users & Roles")
        )
      ),
      bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(tabName = "Tasks",
                           h1("Study ABX0231345 – Operations Dashboard"),
                           mod_kpi_card_overview_dummy_ui("kpi_cards"),
                           shiny::fluidRow(
                             shiny::column(
                               6,
                               # mod_pie_charts_overview_ui("pie_chart")),
                             mod_pie_chart_ui("task_completion_rate", pie_chart_title = "Output Delivery Rate")),
                             shiny::column(6,
                                           mod_bar_chart_ui('total_completion_rate_by_study',bar_chart_title = "Pending Deliverables for Study"))

                           ),
                           shiny::fluidRow(
                             shiny::column(
                               6,
                               mod_bar_chart_ui("bar_chart")
                             ),
                             shiny::column(
                               6,
                               mod_area_chart_ui("area_chart")
                             )
                           )
          ),
          bs4Dash::tabItem(tabName = "Studies",
                           h1("Need to add content.")
          ),
          bs4Dash::tabItem(tabName = "Users & Roles",
                           h1("Need to add content.")
          ))
      ),
      dark = NULL
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "CDRSCE.task.analysis.dashboard"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
