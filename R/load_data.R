#' task_summary_data
#' Read task summary data from data for reporting excel file for calculations
#'
#' @param x A number.
#' @param y A number.
#' @return A number.
#' @export
#' @examples
task_summary_data_fun <- function() {
  data <- openxlsx::readWorkbook("data/ODR - DataforReporting.xlsx", sheet = "Task Summary", detectDates = TRUE)
  data[, "Last.Updated.At"] <- lubridate::as_datetime(data$Last.Updated.At, tz = "Asia/Calcutta")
  task_summary_data <- data |> dplyr::select("Task.Id", "Study.Name", "Task.Group", "Due.Date", "Last.Updated.At", "Overall.Status", "Completed", "Programs", "Outputs", "Open.Issues.Count")
  usethis::use_data(task_summary_data, overwrite = TRUE)
}
