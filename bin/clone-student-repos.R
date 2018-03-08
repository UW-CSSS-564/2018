#!/usr/bin/env Rscript
#' Clone all student repositories
suppressPackageStartupMessages({
  library("purrr")
  library("gh")
  library("git2r")
})

#' Get team
#'
#' Get information for the GitHub team named \code{team} in organization \code{org}.
#'
#' There is no direct way to get team info by name from the GitHub API.
#' This gets the list of teams in the \code{org} and filters by name to
#' return the team (if it exists).
#'
#' @param teamname \code{string}. Name of the GitHub team
#' @param org \code{string}. Name of the GitHub organization.
#' @returns \code{list} The object returned by
get_team <- function(teamname, org) {
  gh("GET /orgs/:org/teams", org = org) %>%
    keep(~ .x[["name"]] == teamname) %>%
    pluck(1)
}

# Organization name
ORG <- "UW-POLS501"
# Student team
STUDENT_TEAM <- "2018 students"

# clone the url at `url` to
clone_single_repo <- function(url) {
  local_path <- file.path(path, tools::file_path_sans_ext(basename(url)))
  local_path <- normalizePath(local_path)
  if (!dir.exists(local_path)) {
    message(glue("Cloning {url} to {local_path}."))
    git2r::clone(url, local_path)
    local_path
  } else {
    warning(glue("WARNING: Not cloning {url} because {local_path}",
                 " already exists."))
  }
}

#' Clone all student repos
#'
#' For the GitHub organization \code{org}, for all members of
#' the team \code{team}, download the their project directory, which is
#' named \code{'org/:studentname'}.
#'
#' @param org string. GitHub organization name for the course
#' @param team string. GitHub team name for the students
#' @param local_path string. Local directory to clone repositories to.
#' @param use_ssh flag. If \code{TRUE}, the use SSH to clone the directories,
#'    else use HTTPS.
#' @returns
clone_all_repos <- function(org, team, path = ".", use_ssh = TRUE) {
  student_team <- get_team(team, org)

  # get all student info
  students <- gh("/teams/:id/members", id = student_team$id,
                 role = "member") %>%
    map_chr("login")

  repos <- map(students, ~ gh("/repos/:owner/:repo", owner = ORG,
                              repo = .x))
  url_key <- if (use_ssh) "ssh_url" else "clone_url"
  urls <- map_chr(repos, url_key)
  map(urls, clone_single_repo)

}

