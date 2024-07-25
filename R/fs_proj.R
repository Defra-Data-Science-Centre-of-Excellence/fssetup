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
#' @export

fs_proj <- function(path, ...) {
  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  FSsetup::create_fs_readme(type = "project",
                            format = "html",
                            file_path = path)

  # set file structure
  structure <- c("01_data", "02_src", "03_outputs")

  # add folders based on structure
  for (i in 1:length(structure)) {
    dir.create(glue::glue("{path}/{structure[i]}"))
  }

}
