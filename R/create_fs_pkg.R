#' @title
#' Create an R package based on the Farming Stats template
#'
#' @description
#' This function will create an R package using the Farming
#' Stats template.
#'
#' @details
#' Use this function to create an R package based on the
#' farming stats template. The function should be run
#' within an already established R project.
#'
#' For easy git integration, first set up a repo on
#' GitHub, then clone the repo to you local directory,
#' then run this function. Though this is not necessary
#' if your package is not being pushed to GitHub.
#'
#' This function will add:
#' \itemize{
#'    \item DESCRIPTION
#'    \item NAMESPACE
#'    \item MIT License
#'    \item Defra licence
#'    \item R folder
#'    \item gitignore
#'    \item buildignore
#'    \item README Qmd and MD
#' }
#'
#'
#' @param argument description add more as needed
#'
#' @param argument description add more as needed
#'
#' @return
#' The output will be all the necessary package
#' files within your repo.
#'
#' @export

create_fs_pkg <- function() {

  ## 1. Check tools ----

  pkgbuild::check_build_tools()

  # this function will check you have the appropriate tools to create an R
  # package installed.

  ## 2. Add core package files ----

  devtools::create(here::here())

  # this function will add all the core package files to the project folder
  # we are in (note need to have opened your package as an R project before
  # this step is run). It will add things like the Description file, R folder
  # etc etc.

  ## 3. Add licence ----

  usethis::use_mit_license(here::here())

  # this will add the basic MIT licence. To which we can add a Defra specific
  # one.

  ## 4. Run checks ----

  devtools::check(here::here())

  # this function will check that all the core package elements have been
  # created. It runs various checks and will print a warning message or
  # error message if things aren't right.

}
