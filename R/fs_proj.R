#' @title
#' Function for RStudio project template
#'
#' @description
#' This is a function that is called in the "New project"
#' viewer pane when the user chooses a Farming Stats
#' Project template. It should not be used away from the
#' RStudio viewer. If you would like to manually add project
#' files, use the function`create_fs_proj` instead.
#'
#' I have not included additional information on how to use
#' this function, as it is not intended to be used outside
#' the template call.
#'
#' To subsequently link this to a github repo, the best
#' plan is to use `usethis::use_github()`. See the
#' documentation here:
#'
#' https://happygitwithr.com/existing-github-last
#'
#' @export

fs_proj <- function(path, ...) {
  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # collect inputs and paste together as 'Parameter: Value'
  params <- list()
  dots <- list(...)
  for (i in seq_along(dots)) {
    key <- names(dots)[[i]]
    val <- dots[[i]]
    params[[key]] <- val
  }

  # set default author if no text entered
  params$author <- ifelse(is.null(params$author),
                          "Author name",
                          params$author)

  # set default title if no text entered
  params$title <- ifelse(is.null(params$title),
                          "Project title",
                          params$author)


  FSsetup::create_fs_readme(type = "project",
                            format = params$readme,
                            file_path = path,
                            author = params$author,
                            readme_title = params$title)

  # set file structure
  structure <- c("01_data", "02_src", "03_outputs")

  # add folders based on structure
  for (i in 1:length(structure)) {
    dir.create(glue::glue("{path}/{structure[i]}"))
  }

  if (params$pipeline == TRUE) {
    FSsetup::create_fs_script(file_name = "pipeline",
                              file_path = path,
                              author = params$author)
  }

  if (params$gitignore == TRUE) {
    FSsetup::create_fs_gitignore(file_path = path)
  }

}
