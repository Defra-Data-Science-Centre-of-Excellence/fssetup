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
#' @param private if TRUE creates private repo
#'
#' @return
#' R project is truned into a git repo and an
#' associated github repo si created in the users
#' github account.
#'
#' @export

fs_use_github <- function(private = TRUE) {

  ## Need to make Git repo first
  usethis::use_git()


  ## now add repo to github
  usethis::use_github(private = private)

}
