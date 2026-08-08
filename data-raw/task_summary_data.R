## code to prepare `task_summary_data` dataset goes here
data <- openxlsx::readWorkbook("data/ODR - Data.xlsx", sheet = "Task Summary", detectDates = TRUE)
data[, "Last.Updated.At"] <- lubridate::as_datetime(data$Last.Updated.At, tz = "Asia/Calcutta")
task_summary_data <- data |> dplyr::select("Task.Id", "Study.Name", "Task.Group", "Due.Date", "Last.Updated.At", "Overall.Status", "Completed", "Programs", "Outputs", "Open.Issues.Count")
usethis::use_data(task_summary_data, overwrite = TRUE)
