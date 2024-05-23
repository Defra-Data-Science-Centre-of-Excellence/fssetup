#' @title
#' Create an default R script template.
#'
#' @description
#' This function can be used to create a default
#' R script template. All scripts opened from this
#' point will have this template applied as a header.
#' More information provided in the details section.
#'
#' @details
#' This function is used to create a new template
#' for R scripts. This will be the default that all
#' subsequent R scripts opened will contain. By doing
#' this is it should be easier to follow best practice
#' and properly comment all scripts you create.
#'
#' The default is stored in the appdata folder on your
#' c drive: "~/AppData/Roaming/RStudio". It will create
#' a "templates" folder where the default will be stored.
#'
#' The function has various ways it can work which will
#' give you the ability to create whatever header template
#' you wish. It has four ways formatting options:
#' \itemize{
#'    \item farming_stats
#'    \item custom
#'    \item manual_edit
#'    \item blank
#' }
#'
#' "farming_stats" will pre-load the default script with
#' the farming stats template.
#'
#' "custom" will allow you to provide your own custom template
#' as a string, which will then be added to the default.
#'
#' "manual" will allow you to manually edit the default template.
#' It will open it in your R studio window and manual edits can
#' be saved. Note, this can also be used to tweak a pre-existing
#' template (e.g. to add your name and email to all scripts).
#'
#' "blank" will delete he default R script and template. This
#' returns R back to normal, and any script opened subsequently
#' will be blank.
#'
#' @param format what format the template will take. There are
#' four options: "farming_stats" (default farming stats template),
#' "custom" will apply a custom template (provided as a string),
#' "manual_edit" will open the template so you can manually edit
#' the template, and "blank" can be used to remove all pre-existing
#' templates. Note: manual edit can also be used to edit existing
#' templates.
#'
#' @param template default is NULL, only used if format = "custom".
#' Used to provide custom template design. Must be provided as
#' a string. Must be provided if using format = "custom" or the
#' function will return an error.
#'
#' @return
#' New .R file created at "~/AppData/Roaming/RStudio/templates/default.R"
#' containing the script template
#'
#' @export

create_fs_script_template <- function(format = c("farming_stats",
                                                 "custom",
                                                 "manual_edit",
                                                 "blank"),
                                      template = NULL) {



  if (format == "farming_stats") {

    # create template file if it doesn't exist already
    if (!fs::file_exists("~/AppData/Roaming/RStudio/templates")) {
      fs::dir_create(path = "~/AppData/Roaming/RStudio/templates")
    }

    # make FS header template
    header <- c(
      "## - - - - - - - - - - - - - -",
      "##",
      "## Organisation: Defra Agri-Foodchain Directorate (Evidence & Analysis)",
      "##",
      "## Project:",
      "##",
      "## Script name: ",
      "##",
      "## Purpose of script: ",
      "##",
      "## Author: ",
      "##",
      "## Email: ",
      "##",
      "## Date Created: ",
      "##",
      "## - - - - - - - - - - - - - -",
      "## Notes:",
      "##" ,
      "##",
      "## - - - - - - - - - - - - - -",
      "## Packages:",
      "",
      "# Pacman",
      "if(!require(pacman)){",
      "  install.packages(\"pacman\")",
      "  library(pacman) # for automatic install of missing packaged through p_load",
      "}",
      "",
      "# Common packages (add additional packages as needed):",
      "p_load(",
      "  glue,",
      "  here,",
      "  openxlsx,",
      "  readODS,",
      "tidyverse",
      ")",
      "",
      "## - - - - - - - - - - - - - -",
      "## Sourced files:",
      "",
      "## - - - - - - - - - - - - - -",
      ""
    )

    # Create default R script template with header
    cat(header,
        file = fs::path_expand("~/AppData/Roaming/RStudio/templates/default.R"),
        sep = "\n")

  } else if (format == "custom") {

    # check template provided
    if (is.null(template)){
      cli::cli_alert_danger(cli::col_red("No template provided - aborting!"))
      stop("Error: no template provided.")
    }

    # create template file if it doesn't exist already
    if (!fs::file_exists("~/AppData/Roaming/RStudio/templates")) {
      fs::dir_create(path = "~/AppData/Roaming/RStudio/templates")
    }

    # Create default R script template with header provided
    cat(template,
        file = fs::path_expand("~/AppData/Roaming/RStudio/templates/default.R"),
        sep = "\n")

  } else if (format == "manual_edit") {
    # create template file if it doesn't exist already
    if (!fs::file_exists("~/AppData/Roaming/RStudio/templates")) {
      fs::dir_create(path = "~/AppData/Roaming/RStudio/templates")
    }

    # Create the default file if doesn't exist already
    if (!fs::file_exists("~/AppData/Roaming/RStudio/templates/default.R")) {
      fs::file_create("~/AppData/Roaming/RStudio/templates/default.R")
    }

    # Open the file in RStudio to edit it
    usethis::edit_file("~/AppData/Roaming/RStudio/templates/default.R")

  } else if (format == "blank") {
    # this removes any pre-existing defaults
    fs::file_delete("~/AppData/Roaming/RStudio/templates/default.R")
  }
}
