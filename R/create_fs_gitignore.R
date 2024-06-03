#' @title
#' Create a gitignore file based on the Farming Stats template
#'
#' @description
#' Use this function to create a gitignore for a
#' Farming Stats project.
#'
#' @details
#' This function will create a gitignore for a
#' project using a pre-defined Farming Stats template.
#'
#' Used as default, it will automatically add the
#' data and output folders (as created in the
#' `create_fs_proj` function). This is to ensure
#' nor restricted data or unpublished results are
#' accidentally pushed to GitHub.
#'
#' Alternatively, a custom gitignore can be provided
#' by setting `type to` "custom" and providing a custom
#' template to `custom_txt` as a string.
#'
#' Note it will replace any existing .gitignore
#' files present in the project already.
#'
#'
#' @param type description controlling which gitignore
#' is added. "default" will add the standard template.
#' "custom" will enable the user to provide a custom
#' template via `custom_txt`.
#'
#' @param file_path optional argument allowing users
#' to specify file path where gitignore should be created.
#' If not entered, will default to current project/working
#' directory.
#'
#' @param custom_txt optional argument allowing users to
#' provide their own gitignore template. Must be provided
#' as a string. Only used if type set to "custom".
#'
#' @return
#' A gitignore file is added to the project.
#'
#' @export
create_fs_gitignore <- function (type = c("default", "custom"),
                                 file_path = NULL,
                                 custom_txt = NULL) {

  # path to save
  if (!is.null(file_path)) {
    path = file_path
  } else {
    file_path <- here::here()
  }

  # set readme text.
  if (type == "default") {
    # gitignore template
    gitignore_txt <- stringr::str_c("# gitignore ---- \n",
                                    "## Ignore R history files ---- \n",
                                    ".Rhistory\n",
                                    ".Rapp.history\n",
                                    "\n",
                                    "## Ignore R data files ---- \n",
                                    "*.RData\n",
                                    "\n",
                                    "## Ignore RStudio project files ---- \n",
                                    ".Rproj.user/ \n",
                                    "*.Rproj\n",
                                    "\n",
                                    "## Ignore sensitive files ---- \n",
                                    "01_data/ \n",
                                    "03_outputs/ \n",
                                    "\n",
                                    "# add additional files as required")
  } else if (type == "custom") {
    if (is.null(custom_txt) == TRUE) {
      cli::cli_alert_danger(cli::col_red("Type set to custom but no custom_txt provided!\n"))
      cli::cli_alert_info(cli::col_cyan("Please provide custom_txt or set type to default."))
    } else {
      gitignore_txt <- custom_txt
    }
  }

  # save file
  cat(gitignore_txt,
      file = glue::glue("{path}/.gitignore"),
      sep = "\n")
}
