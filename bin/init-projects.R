#' Initialize the files for all assignments in content/assignments/
library("tidyverse")
library("lubridate")
library("glue")
library("here")

save_assignment <- function(i) {
  template <-
    str_c(str_c("---",
                glue("title: \"Project Assignment {i}\""),
                "Draft:  true",
                "dateDue: null",
                "---", sep = "\n"),
          "\n")
  filename <- glue(here("content", "project", "project-assignment-{i}.Rmd"))
  cat(template, file = filename)
  filename
}

map(seq_len(7), save_assignment)
