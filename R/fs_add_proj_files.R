#' @title Add default project files to an existing project/repo
#'
#' @author Josh Moatt
#'
#' @description Simple function to add the standard project files to an existing
#'   R Project or local GitHub Repo. This should be used when setting up a new
#'   project after initial set up - particularly useful for if you have just
#'   cloned a new GitHub repo and want to add the template project files.
#'
#' @details The function is designed to be used after manually creating a local
#'   version of a GitHub repo.
#'
#'   The function will add the following:
#'
#' \itemize{
#'    \item data, src and outputs folders
#'    \item README using `create_fs_readme`
#'    \item pipeline script using `create_fs_script`
#'    \item optionally creates a gitignore using `create_fs_gitignore`
#' }
#'
#'   The function allows users to include the author and project title when
#'   calling the function, which will be prefilled
#'
#' @param path string containing file path to add files. Default is current
#'   directory (set using `here()`)
#'
#' @param author string with author name. If no name provided, defaults to
#'   "Author name"
#'
#' @param title string with project title. If no title provided, defaults to
#'   "Project title"
#'
#' @param readme string specifying readme format. One of "github", "markdown" or
#'   "html". Default is "github"
#'
#' @param github logical controlling whether a gitignore is added. Default is
#'   TRUE
#'
#' @return project files added to specified directory
#'
#' @export
fs_add_proj_files <- function(path = here::here(),
                              author = "Author name",
                              title = "Project title",
                              readme = "github",
                              gitignore = TRUE) {

  # check format
  if (!readme %in% c("markdown", "github", "html")){
    stop('Invalid readme format - pick one of "github", "html" or "markdown"!')
  }

  # add readme
  fssetup::create_fs_readme(format = readme,
                            file_path = path,
                            author = author,
                            readme_title = title)

  # add pipeline script
  fssetup::create_fs_script(file_name = "pipeline",
                            file_path = path,
                            author = author)

  # set file structure
  structure <- c("data", "src", "outputs")

  # add folders based on structure
  for (folder in structure) {
    dir.create(file.path(path, folder), recursive = TRUE, showWarnings = FALSE)
  }

  if (gitignore) {
    fssetup::create_fs_gitignore(file_path = path)
  }
}
