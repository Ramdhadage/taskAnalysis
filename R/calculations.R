upcomming_task_duration <- 10 # number of days to be consider to calculate upcomming task count

# CDRSCE.task.analysis.dashboard::task_summary_data_fun()
# Total number of tasks with no due date --------


due_date_count <- function() {
  due_date_count <- task_summary_data |>
    dplyr::count(Due.Date) |>
    dplyr::filter(is.na(Due.Date))
  ifelse(nrow(due_date_count) == 0, 0, due_date_count |> dplyr::pull())
}
# Total no. of tasks overdue and not completed as of today -----

overdue_and_not_completed <- function() {
  task_summary_data |>
    dplyr::filter(!Completed) |>
    dplyr::select(Due.Date) |>
    na.omit() |>
    dplyr::summarise(sum(Due.Date >= lubridate::today())) |>
    dplyr::pull()
}
# Total no. of tasks not completed but overall status marked as completed ------

not_completed_and_status_completed <- function() {
  not_completed_and_status_completed <- task_summary_data |>
    dplyr::count(Completed, Overall.Status) |>
    dplyr::filter(!Completed, Overall.Status == "Pass")
  ifelse(nrow(not_completed_and_status_completed) == 0, 0, not_completed_and_status_completed |> dplyr::pull())
}
# total no. of upcoming tasks ----

upcomming_task_count <- function() {
  upcomming_task_count <- task_summary_data |>
    dplyr::filter(Overall.Status == "Not Run", Due.Date >= lubridate::today(), Due.Date <= lubridate::today() + upcomming_task_duration) |>
    dplyr::count(Due.Date)
  ifelse(nrow(upcomming_task_count) == 0, 0, upcomming_task_count |> dplyr::pull())
}

# Total no. of programs -----

program_count <- function() {
  task_summary_data |> dplyr::n_distinct("Programs")
}

# total no. of output files

output_files_count <- function() {
  task_summary_data |> dplyr::n_distinct("Outputs")
}
# total no. of open issues ----
open_issues_count <- function() {
  task_summary_data |> dplyr::summarise(sum(Open.Issues.Count))
}
# total no. of tasks updated in last 24 hrs ----
task_updated_within_24hr_count <- function() {
  sum(abs(task_summary_data |> dplyr::select(Last.Updated.At) |> dplyr::pull() - lubridate::now()) <= 1)
}

# total task completion rate ----
task_completion_rate <- function() {
  task_summary_data |>
    dplyr::count(Completed) |>
    dplyr::mutate(rate = proportions(n) * 100)
  # task_completion_rate$Completed <- as.character(task_completion_rate$Completed)
}
# task completion rate by task group ----
task_completion_rate_by_taskgroup <- function() {
  task_summary_data |>
    dplyr::filter(Completed) |>
    dplyr::count(Task.Group = stringr::str_to_upper(Task.Group)) |>
    dplyr::mutate(rate = proportions(n) * 100) |>
    dplyr::arrange(dplyr::desc(n)) |> dplyr::filter(Task.Group != "TASKGROUP`~!@#$%^&*()-_@#__+==RV02")
}
# total no. of tasks not run by study -----
tasks_not_run_by_study_count <- function() {
  task_summary_data |>
    dplyr::filter(Overall.Status == "Not Run") |>
    dplyr::count(Study.Name) |>
    dplyr::arrange(dplyr::desc(n)) |>
    dplyr::slice_tail(n = -1)
  # tasks_not_run_by_study_count[["Study.Name"]] <- tasks_not_run_by_study_count[["Study.Name"]] |> stringr::str_trunc(width = 12,side = "right")
}

# no. of tasks completed over a time period -----
time_completed_over_durations <- function() {
  # extract date from date time and time data format
  completion_date <- task_summary_data |>
    dplyr::filter(Completed) |>
    dplyr::pull(Last.Updated.At) |>
    lubridate::as_date()
# calculate total number completed distribution for year, quarter and month
  time_completed_over_durations <- tibble::tibble(
    years = lubridate::year(completion_date),
    quarters = lubridate::quarter(completion_date),
    months = as.character(lubridate::month(completion_date, label = TRUE, abbr = FALSE))
  ) |>
    dplyr::count(years, quarters, months)

  # few months are missing so, create a data frame with all possible months
  all_months <- expand.grid(
    years = unique(time_completed_over_durations$years),
    months = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
  )

  # merge the original data with the data frame of all possible months
  time_completed_over_durations_full <- dplyr::left_join(all_months, time_completed_over_durations)

  # replace missing values of counts with 0
  time_completed_over_durations_full$n[is.na(time_completed_over_durations_full$n)] <- 0

  time_completed_over_durations_full |> dplyr::filter(
    years > 2019
  )

}
