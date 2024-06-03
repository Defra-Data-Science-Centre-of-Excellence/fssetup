#' @title
#' Create R project based on the Farming Stats template
#'
#' @description
#' This function will create an R project using the Farming
#' Stats template.
#'
#' @details
#' Use this function to create an R project based on the
#' farming stats template. The function should be run
#' within an already established R project.
#'
#' For easy git integration, first set up a repo on
#' GitHub, then clone the repo to you local directory,
#' then run this function. Though this is not necessary
#' if your package is not being pushed to GitHub.
#'
#' This function will add folders by default (see below).
#' However, if you would like, you can choose an
#' alternative project structure that suits your needs.
#'
#' By default this function will add:
#' \itemize{
#'    \item inputs folder - this should contain all the inputs used
#'    in the project (if appropriate). This could be data, templates,
#'    txt files etc. This can be customised with sub-folders as required.
#'    \item src folder - this should contain all the scripts sourced
#'    into your pipeline. E.g. this may contain functions, or scripts
#'    for reading in the data that can be sourced into the pipeline.
#'    This can be customised with sub-folders as required.
#'    \item output folder - this should be where your outputs are saved
#'    (where appropriate). This can be customised with sub-folders
#'    as required.
#'    \item main pipeline script - this should be where the main code
#'    is that executes your project. This may need to expand to multiple
#'    scripts, but should be the active pipeline code (rather than scripts
#'    containing functions etc).
#'    \item README (Qmd and MD) - with all R projects you should provide
#'    a full README that gives users all the information they need to run
#'    your project. You should edit this as you develop you project.
#' }
#'
#' @param readme_format controls the output format of the
#' README. Default is "markdown", but can be "html"
#' or "github".
#'
#' @param file_path optional string containing file path to
#' project folder. Default is the current working directory.
#'
#' @param proj_struc optional vector containing the project
#' structure you want. Default is to add the accepted Farming
#' Stats skeleton, which is described in the details.
#'
#' @return
#' Output is all the files needed for a basic R project based
#' on the Farming Stats template.
#'
#' @export

# https://github.com/JT-39/dauRtemplate/blob/main/R/dau_proj_template.R


create_fs_proj <- function(readme_format = c("markdown",
                                             "github",
                                             "html"),
                           file_path = NULL,
                           proj_struc = NULL) {

  if ( !is.null(file_path)) {
    path <- file_path
  } else {
    path = here::here()
  }

  # project structure
  if (!is.null(proj_struc)) {
    structure <- proj_struc
  } else {
    structure <- c("01_data", "02_src", "03_outputs")
  }

  # add folders based on structure
  for (i in 1:length(structure)) {
    dir.create(glue::glue("{path}/{structure[i]}"))
  }

  # add pipeline script
  FSsetup::create_fs_script(file_name = "pipeline",
                            author = NULL)

  # add readme
  FSsetup::create_fs_readme(type = "project",
                            format = readme_format,
                            file_path = path)

  # add gitignore template
  FSsetup::create_fs_gitignore()

}
