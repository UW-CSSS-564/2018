library("rmarkdown")
library("stringr")
library("tidyverse")

weeks <- dir("content/weeks/", pattern = "week-.*\\.Rmd$",
             full.names = TRUE)
for (path in weeks) {
  metadata <- yaml_front_matter(path)
  week <- metadata[["week"]]
  for (meeting in metadata[["meetings"]]) {
    filename <- str_c(meeting[["date"]], "-",
                      if (meeting[["lab"]]) "lab" else "class",
                      ".Rmd")
    title <- str_c(format(as.Date(meeting[["date"]]), "%b, %d (%a)"), "&mdash;",
                    if (meeting[["lab"]]) "Lab" else "Class",
                    ".Rmd")
    meeting[["title"]] <- title
    meeting[["week"]] <- week
    meeting[["tags"]] <- NULL
    meeting[["readings"]] <- map(meeting[["before"]], "title")
    meeting[["before"]] <- NULL
    meeting[["optional"]] <- map(meeting[["after"]], "title")
    meeting[["after"]] <- NULL
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
    meeting[["date"]] <- meeting[["startTime"]]
    filestr <- str_c("---\n", yaml::as.yaml(meeting), "\n---\n")
    cat(filestr, file = file.path("content", "schedule", filename))
  }
}
