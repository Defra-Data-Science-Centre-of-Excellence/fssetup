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
#' @details
#' This function will take an existing R project
#' on you local machine, turn it into a git repo
#' and create a GitHub repository. It will do the
#' following:
#' \itemize{
#'    \item add a gitignore
#'    \item initalise the git repo
#'    \item stage any uncommitted files
#'    \item commit the files
#'    \item create a GitHub repo
#'    \item restart RStudio to activate the git pane in R
#' }
#'
#' The gitignore is added using the \code{\link{create_fs_gitignore}}
#' function within this package.
#'
#' The repo initialisation, staging and committing is all
#' done using the gert package.
#'
#' Creating the GitHub repo uses the \code{\link[usethis]{use_github}}
#' function from the usethis package.
#'
#' Note: For this function to work you must:
#' \itemize{
#'    \item have git installed on your machine
#'    \item have a GitHub account
#'    \item have your GitHub credentials entered into RStudio
#'    \item have you Personal Access Token (PAT) entered in RStudio
#' }

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

  ## add fs gitignore ----

  cli::cli_alert_success(text = "Adding gitignore", wrap = TRUE)

  # add file
  FSsetup::create_fs_gitignore()

  ## initialise project as git repo ----

  cli::cli_alert_success(text = "Initialising git repo", wrap = TRUE)

  # set repo file path
  repo <- usethis::proj_get()

  # initialise git repo
  gert::git_init(repo)

  ## perform initial commit ----

  # select un-staged files
  uncommitted <- gert::git_status(staged = FALSE)$file

  cli::cli_alert_success(text = "Staging project files", wrap = TRUE)

  # stage repo
  gert::git_add(uncommitted, repo = repo)

  cli::cli_alert_success(text = "Performing initial commit with message: '{message}'",  wrap = TRUE)

  # commit repo
  gert::git_commit(message, repo = repo)

  ## create GitHub repo ----

  cli::cli_alert_success(text = "Creating Github repo",wrap = TRUE)
  cli::cli_alert_info(text = "A GitHub window may open in your browser", wrap = TRUE)

  # create GitHub repo
  usethis::use_github(private = private)

  ## restart project ----

  cli::cli_alert_warning(text = "RStudio must restart to activate the git pane.", wrap = TRUE)
  cli::cli_alert_warning(text = "Restart RStudio now?.", wrap = TRUE)

  # options list:
  cli::cli_bullets(text = c("0 = no",
                            "1 = yes"))

  # user prompt
  response <- readline(prompt = "Please enter 0 or 1: ")

  if (response == "1") {
    cli::cli_alert_success(text = "Restarting RStudio. Click OK on the RStudio prompt",wrap = TRUE)

    # restart rstudio to open git pane
    rstudioapi::openProject(repo)
  } else if (response == "0") {
    cli::cli_alert_warning(text = "Not restarting RStudio!",wrap = TRUE)
    cli::cli_alert_info(text = "The git pane will appear when the project is next re-opened",wrap = TRUE)
  }


}
