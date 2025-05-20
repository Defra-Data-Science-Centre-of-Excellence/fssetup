#' @title Create a GitHub repository from local project.
#'
#' @author Josh Moatt
#'
#' @description This simple function will turn your local R project into a git
#'   repo, then create a repo on GitHub and perform the initial set up and
#'   commit.
#'
#'   By default it will create a private repo on the
#'   Defra-Data-Science-Centre-of-Excellence organisation on GitHub. You can
#'   change where the repo is created using the defra_org argument and change
#'   the repo visibility using the visibility argument when calling the
#'   function.
#'
#'   Note: this function requires you to have a PAT and to have set this in your
#'   RStudio envrionment, even if connecting via SSH. This is because a PAT is
#'   required to create new repos, even when using SSH. See
#'   [usethis::use_github] for more details.
#'
#' @details This function will take an existing R project on you local machine,
#'   turn it into a git repo and create a GitHub repository.
#'
#'   By default it will create a private repo on the
#'   Defra-Data-Science-Centre-of-Excellence organisation on GitHub. This can be
#'   changed using the defra_org argument.
#'
#'   The function will do the following:
#'
#' \itemize{
#'    \item add a gitignore
#'    \item initalise the git repo
#'    \item stage any uncommitted files
#'    \item commit the files
#'    \item create a GitHub repo
#'    \item restart RStudio to activate the git pane in R
#' }
#'
#'   The gitignore is added using the [create_fs_gitignore()] function within
#'   this package.
#'
#'   The repo initialisation, staging and committing is all done using the
#'   `gert` package.
#'
#'   Creating the GitHub repo uses the [use_github()] function from the
#'   `usethis` package.
#'
#'   By default the function will create a private repo. There are three options
#'   controlled by the visibility argument:
#'
#'  \itemize{
#'    \item private
#'    \item internal
#'    \item public
#' }
#'
#'   For the differences between these options, see GitHub. Internal is only an
#'   option when creating a repo  within the Defra organisation. If createing a
#'   personal repo with visibility set to "internal", this will create a private
#'   repo.
#'
#'   For this function to work you must:
#'
#' \itemize{
#'    \item have git installed on your machine
#'    \item have a GitHub account
#'    \item have your GitHub credentials entered into RStudio
#'    \item have your Personal Access Token (PAT) entered in RStudio
#' }
#'
#'   Note: occasionally the function seems to fails to set the master branch and
#'   users are unable to push changes. If this happens try running `git push -u
#'   origin master` in the terminal, this should set you current branch as the
#'   master. We're not sure why this happens, but it is advisable to use
#'   [fs_connect_github()] to set your credentials properly before trying this
#'   function.
#'
#' @param message initial commit message. Default is "Initial commit".
#'
#' @param defra_org logical, default is TRUE. Whether the repo should be created
#'   under the Defra-Data-Science-Centre-of-Excellence (TRUE) or a personal repo
#'   (FALSE).
#'
#' @param visibility string controlling visibility. One of "private" (default),
#'   "internal"  or "public". If defra_org is FALSE repos can only be private or
#'   public. When "internal" used when defra_org is FALSE, a private repo will
#'   be created.
#'
#' @param github_method sting specifying GitHub connection method. One of "ssh"
#'   or "https". By default, the function uses "ssh" as this is the recommended
#'   connection method on the DASH platform.
#'
#' @return R project is turned into a git repo and an associated github repo si
#'   created in the users github account.
#'
#' @export

fs_use_github <- function(message = "Initial commit",
                          defra_org = TRUE,
                          visibility = "private",
                          github_method = "ssh") {

  ## checks ----

  # check visibility
  if (!visibility %in% c("private", "public", "internal")) {
    stop('please set visibility. One of  "private", "internal" or "public"!')
  }

  # check github_method
  if (!github_method %in% c("ssh", "https")) {
    stop('please set connection method to github_method. One of "ssh" or "https"!')
  }

  if (!nzchar(Sys.getenv("GITHUB_PAT"))) {
    stop("You don't have a GitHub PAT set, this function requires a PAT. See documentation for more details.")
  }

  ## add fs gitignore ----

  cli::cli_alert_success(text = "Adding gitignore", wrap = TRUE)

  # add file
  fssetup::create_fs_gitignore()

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
  cli::cli_alert_info(text = "A GitHub bad gateway window may open in your browser. Refresh the page to see your repo.", wrap = TRUE)

  if (defra_org) {
    # create GitHub repo
    usethis::use_github(organisation = "Defra-Data-Science-Centre-of-Excellence",
                        visibility = visibility,
                        protocol = github_method)
  } else if (!defra_org) {
    # private
    private_repo <- ifelse(visibility == "public",
                           FALSE,
                           TRUE)

    # create GitHub repo
    usethis::use_github(private = private_repo,
                        protocol = github_method)
  }

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
