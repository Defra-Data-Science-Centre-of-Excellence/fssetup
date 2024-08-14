#' @title
#' Addin to open new script with Farming Stats template
#'
#' @description
#' This addin will open a new blank R script which is populated with the Farming
#' Stats header. Unlike the [create_fs_script()] function, this addin will also
#' pre-populate the date.
#'
#' @details
#' This addin will create a new blank script that is populated with the farming
#' stats template header. Unlike the [create_fs_script()] function in this
#' package, this will auto-populate the script with today's date.
#'
#' Addins must use the rstudioapi package. This addin uses the [documentNew()]
#' function from the `rstudioapi` package to open the new R script.
#'
#' Note: this opens an normal untitled script. It must be manually saved in the
#' correct directory.
#'
#' This package also contains another addin to open an R script with a roxygen
#' header, which can be used for creating scripts within packages.
#'
#' @return
#' A script will open in RStudio.
#'
#' @export

addin_fs_script <- function() {

  # make FS header template
  header <- stringr::str_c(
    "## - - - - - - - - - - - - - - \n",
    "## \n",
    "## Organisation: Defra Agri-Foodchain Directorate (Evidence & Analysis) \n",
    "## \n",
    "## Project: \n",
    "## \n",
    "## Script name: \n",
    "## \n",
    "## Purpose of script: \n",
    "## \n",
    "## Author: \n",
    "## \n",
    "## Email: \n",
    "## \n",
    "## Date Created: ", format(Sys.Date(), "%d/%m/%Y"), " \n",
    "## \n",
    "## - - - - - - - - - - - - - - \n",
    "## Notes: \n",
    "## \n" ,
    "## \n",
    "## - - - - - - - - - - - - - - \n",
    "## Packages: \n",
    "\n",
    "# Pacman \n",
    "if (!require(pacman)) { \n",
    "  install.packages(\"pacman\") \n",
    "  library(pacman) # for automatic install of missing packaged through p_load \n",
    "} \n",
    "\n",
    "# Common packages (add additional packages as needed): \n",
    "p_load( \n",
    "  glue, \n",
    "  here, \n",
    "  openxlsx, \n",
    "  readODS, \n",
    "  tidyverse \n",
    ") \n",
    "\n",
    "## - - - - - - - - - - - - - - \n",
    "## Sourced files: \n",
    "\n",
    "## - - - - - - - - - - - - - - \n")

  # Open using Rstudio API
  rstudioapi::documentNew(text = header,
                          type = "r",
                          execute = FALSE,
                          position = 43)
}
