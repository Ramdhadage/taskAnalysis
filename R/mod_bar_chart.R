#' bar_chart UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'

#'
#' @importFrom shiny NS tagList
mod_bar_chart_ui <- function(id, bar_chart_title = "Pending Deliverables Across Studies") {
  ns <- NS(id)
  tagList(
    bs4Dash::box(
      id = "bar_chart_box",
      div(echarts4r::echarts4rOutput(ns("bar_chart")),id = "bar_chart_outer"),
      title = bar_chart_title,
      status = "info",
      width = 12, maximizable = TRUE

    )
  )
}

#' bar_chart Server Functions
#'
mod_bar_chart_server <- function(id, bar_chart_values = tasks_not_run_by_study_count()$n, bar_chart_labels = tasks_not_run_by_study_count()$Study.Name, x_axis_name = "Study Name", y_axis_name = "Total # Tasks") {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # Rendering bar chart----
    output$bar_chart <- echarts4r::renderEcharts4r({
      tibble::tibble(bar_chart_labels,bar_chart_values) |>
        echarts4r::e_chart(bar_chart_labels) |>
        echarts4r::e_bar(bar_chart_values) |>
        echarts4r::e_datazoom(x_index = 0) |>
        echarts4r::e_x_axis(axisLabel = list(rotate = 45)) |>
        echarts4r::e_legend(show = FALSE) |>
        echarts4r::e_hide_grid_lines() |>
        echarts4r::e_labels(position = "inside",fontWeight = 'bold',  fontSize = 14) |>
        echarts4r::e_x_axis(name = x_axis_name, nameLocation = "center", nameTextStyle = list(fontStyle = "oblique", fontWeight = "bold", padding = 70)) |>
        echarts4r::e_y_axis(name = y_axis_name, nameLocation = "center", nameTextStyle = list(fontStyle = "oblique", fontWeight = "bold", padding = 20)) |>
        echarts4r::e_toolbox_feature(feature = "saveAsImage") |>
        echarts4r::e_toolbox_feature(feature = "dataZoom", title = list(zoom = "zoom", back = "back")) |>
        echarts4r::e_toolbox_feature(feature = "dataView") |>

        echarts4r::e_toolbox_feature(feature = "magicType",type = list("line", "bar")) |>
        echarts4r::e_toolbox_feature(feature = "restore")


    })
  })
}

## To be copied in the UI
# mod_bar_chart_ui("bar_chart_1")

## To be copied in the server
# mod_bar_chart_server("bar_chart_1")
