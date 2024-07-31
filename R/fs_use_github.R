#' @title
#' Create a GitHub repository from local project.
#'
#' @description
#' This simple function will turn your local R
#' project into a git repo, then create a repo
#' on GitHub and perform the initial set up and
#' commit.
#'
#' Note: by default creates a private repo
#' to ensure security. Can be change if the
#' repo needs to be public. Can also be done
#' in GitHub at a later date.
#'
#' @param message initial commit message. Default
#' is "Initial commit".
#'
#' @param private if TRUE creates private repo.
#'
#' @return
#' R project is truned into a git repo and an
#' associated github repo si created in the users
#' github account.
#'
#' @export

fs_use_github <- function(message = "Initial commit",
                          private = TRUE) {

  # add fs gitignore
  FSsetup::create_fs_gitignore()

  # set repo filepath
  repo <- usethis::proj_get()

  # initialise git repo
  gert::git_init(repo)

  # select un-staged files
  uncommitted <- gert::git_status(staged = FALSE)$file

  # stage repo
  gert::git_add(uncommitted, repo = repo)

  # commit repo
  gert::git_commit(message, repo = repo)

  ## now add repo to github
  usethis::use_github(private = private)

  # restart rstudio to open git pane
  rstudioapi::openProject(repo)

}
