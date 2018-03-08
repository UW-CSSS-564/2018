#!/usr/bin/env Rscript
#' Clone all forks or a repo (but meant for assignment)
suppressPackageStartupMessages({
  library("purrr")
  library("glue")
  library("gh")
  library("git2r")
})


#' Download all forks of a GitHub repo
#'
#' Clone all forks of the the repository \code{:owner/:repo} to a local
#' path.
#'
#'
#' @param repo string. Repository Name
#' @param use_ssh flag. If \code{TRUE}, the use SSH to clone the directories,
#'    else use HTTPS.
#' @returns A list of \code{git_repository} objects
clone_all_forks <- function(owner, repo, path = ".", use_ssh = TRUE) {
  forks <- gh("/repos/:owner/:repo/forks", owner = owner, repo = repo)
  # TODO: could filter forks by whether user is a student?
  url_key <- if (use_ssh) "ssh_url" else "clone_url"

  # create path dir if it doesn't exist
  dir.create(file.path(path, repo), recursive = TRUE, showWarnings = FALSE)

  out <- list()
  for (i in seq_along(forks)) {
    fork <- forks[[i]]
    url <- fork[[url_key]]
    fork_owner <- fork[["owner"]][["login"]]
    local_path <- file.path(repo, fork_owner)
    if (!dir.exists(local_path)) {
      message(glue("Cloning {url} to {local_path}."))
      out[[url]] <- git2r::clone(url, local_path)
    } else {
      # what to do if the local path already exists?
      # if the path exists and is a git repo: warn but continue. this doesn't
      # check that it is actually a fork of the original repo.
      # if the path doesn't exist: stop
      warning(glue("WARNING: Not cloning {url} because {local_path}",
                   " already exists."))
      out[[url]] <- tryCatch({
        repository(local_path)
      }, error = function(e) {
        stop("ERROR: {local_path} is not a git repository")
      })
    }
  }
  out
}



