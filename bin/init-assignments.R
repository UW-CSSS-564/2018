#' Initialize the files for all assignments in content/assignments/
library("tidyverse")
library("lubridate")
library("glue")
library("here")

save_assignment <- function(i, assignedDate) {
  template <-
    str_c(str_c("---",
                glue("title: \"Assignment {i}\""),
                "Draft:  true",
                glue("dateAssigned: {assignedDate}T16:30:00"),
                glue("dateDue: {assignedDate + 7}T16:30:00"),
                glue("dateCorrectionsDue: {assignedDate + 14}T16:30:00"),
                glue("assignmentURL: https://github.com/UW-POLS501/2018-assignment-{i}"),
                glue("solutionsURL: https://github.com/UW-POLS501/2018-assignment-{i}-solutions"),
                "---", sep = "\n"),
          "\n")
  filename <- glue(here("content", "assignments", "assignment-{i}.Rmd"))
  cat(template, file = filename)
  filename
}

dates <- as.Date("2018-01-09") + dweeks(0:8)

map2(seq_along(dates), dates, save_assignment)
