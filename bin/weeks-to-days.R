library("rmarkdown")
library("stringr")
library("tidyverse")

weeks <- dir("content/schedule/", pattern = "week-.*\\.Rmd$",
             full.names = TRUE)

path <- weeks[[i]]
metadata <- yaml_front_matter(path)
week <- metadata[["week"]]
for (meeting in metadata[["meetings"]]) {
  filename <- str_c(meeting[["date"]], "-",
                    if (meeting[["lab"]]) "lab" else "class",
                    ".Rmd")
  meeting[["week"]] <- week
  if (meeting[["lab"]]) {
    meeting[["startTime"]] <- str_c(format(meeting[["date"]]),
                                    "T13:30:00")
    meeting[["endTime"]] <- str_c(format(meeting[["date"]]),
                                  "T14:20:00")
  } else {
    meeting[["startTime"]] <- str_c(format(meeting[["date"]]),
                                    "T14:30:00")
    meeting[["endTime"]] <- str_c(format(meeting[["date"]]),
                                  "T15:50:00")
  }
  filestr <- str_c("---\n", yaml::as.yaml(meeting), "\n---\n")
  cat(filestr, file = file.path("content", "schedule2", filename))
}



