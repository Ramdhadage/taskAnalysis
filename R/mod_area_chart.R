#' area_chart UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_area_chart_ui <- function(id) {
  ns <- NS(id)
  tagList(
    bs4Dash::box(
      echarts4r::echarts4rOutput(ns("area_chart")),
      title = "Outputs Completed Over Time",
      status = "info",
      width = 12, maximizable = TRUE
    )
  )
}

#' area_chart Server Functions
#'
#' @noRd
mod_area_chart_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    output$area_chart <- echarts4r::renderEcharts4r({
      time_completed_over_durations() |>
        echarts4r::group_by(years) |>
        # dplyr::arrange(months) |>
        echarts4r::e_chart(months, timeline = TRUE) |>
        echarts4r::e_timeline_opts( padding = 0, left = 15) |>
        echarts4r::e_area(n, symbolSize = 10) |>
        echarts4r::e_mark_line(data = list(yAxis = 5)) |>
        echarts4r::e_legend(show = FALSE) |>
        echarts4r::e_x_axis(axisLabel = list(rotate = 90)) |>
        echarts4r::e_labels(position = "top",fontWeight = 'bold',  fontSize = 14) |>
        echarts4r::e_x_axis(name = "Month", nameLocation = "center", nameTextStyle = list(fontStyle = "oblique", fontWeight = "bold",padding = 20), minorTick = list(show = FALSE)) |>
        echarts4r::e_y_axis(name = "Count of Task id", nameLocation = "center", nameTextStyle = list(fontStyle = "oblique", fontWeight = "bold")) |>
        echarts4r::e_hide_grid_lines() |>
        echarts4r::e_toolbox_feature(feature = "saveAsImage") |>
        echarts4r::e_toolbox_feature(feature = "dataZoom", title = list(zoom = "zoom", back = "back")) |>
        echarts4r::e_toolbox_feature(feature = "dataView") |>
        echarts4r::e_toolbox_feature(feature = "magicType",type = list("line", "bar")) |>
          echarts4r::e_toolbox_feature(feature = "restore") |>
          echarts4r::e_tooltip(formatter = htmlwidgets::JS("
      function(params){
        return('Months: ' + params.value[0] + '<br />Task Completion Count: ' + params.value[1])
      }
    "))
    })
  })
}

## To be copied in the UI
# mod_area_chart_ui("area_chart_1")

## To be copied in the server
# mod_area_chart_server("area_chart_1")
