#' Add a box maximization observer to automatically resize a plot in that box.
#'
#' @param input The input of a shiny app session.
#' @param box_id The shiny ID of the box to observe.
#' @param plot_name The shiny ID of the plot to resize.
#' @param non_max_height The height that the graph should be when the box is
#'   not maximized. Defaults to "400px".
#'   @import plotly
add_plot_maximize_observer <- function(input,
                                       box_id,
                                       plot_name,
                                       non_max_height = "400px") {

  shiny::observeEvent(input[[box_id]]$maximized, {
    plot_height <- ifelse(input[[box_id]]$maximized,"100%",  non_max_height)
    js_call <- sprintf(
      "
      setTimeout(() => {
        $('#%s').css('height', '%s');
      }, 300)
      $('#%s').trigger('resize');
      ",
      plot_name,
      plot_height,
      plot_name
    )
    # document.getElementById("total_completion_rate_by_study-bar_chart").style.height = "100%"
    shinyjs::runjs(js_call)
  }, ignoreInit = TRUE)
}
