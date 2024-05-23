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
#' @param pkg_name string containing package name.
#'
#' @param author string containing author name and email.
#'
#' @param readme_format string indicating readme format.
#' can be "github", "html" or "markdown".
#'
#' @return
#' The output will be all the necessary package
#' files within your repo.
#'
#' @export

create_fs_pkg <- function(pkg_name,
                          author,
                          readme_format = c("github",
                                            "html",
                                            "markdown")) {

  ## 1. Check tools ----

  # this function will check you have the appropriate tools to create an R
  # package installed.

  check_tools <- pkgbuild::has_build_tools()

  if (check_tools == FALSE) {
    cli::cli_alert_danger(cli::col_red("Not all tools to build backages installed!"))
    cli::cli_alert_info(cli::col_blue("Check available packages and install missing dependencies"))
    stop("Missing tools")
  } else if (check_tools == TRUE) {
    cli::cli_alert_success(cli::col_green("All tools found - your system is ready to build packages!"))
  }


  ## 2. Add core package files ----

  # this function will add all the core package files to the project folder
  # we are in.

  devtools::create(here::here())

  ## 3. Add MIT licence ----

  # This will add the basic MIT licence.
  usethis::use_mit_license(copyright_holder = glue::glue("{pkg_name}"))


  ## 4. Add Crown Copyright ----

  # create string
  defra_licence <- stringr::str_c("YEAR: ",
                                  format(Sys.Date(), "%Y"),"\n",
                                  "COPYRIGHT HOLDER: Crown Copyright Defra")

  # save Licence
  cat(defra_licence,
      file = here::here("LICENSE"),
      sep = "\n")


  ## 5. Run checks ----

  # this function will check that all the core package elements have been
  # created. It runs various checks and will print a warning message or
  # error message if things aren't right.

  devtools::check(here::here())

  ## 6. Create README Qmd ----

  # this will create a quarto readme with basic information ready
  # to be populated. it will also render an initial version of the
  # readme in gfm format (ready for github).

  FSsetup::create_fs_readme(type = "package",
                            format = readme_format,
                            author = author,
                            readme_title = stringr::str_c("README for ", pkg_name, " package"))


  # # output format
  # if (readme_format == "github") {
  #   out_format <- "  gfm: default\n"
  # } else if (readme_format == "html") {
  #   out_format <- stringr::str_c("  html:\n",
  #                                "    self-contained: true\n")
  # } else {
  #   out_format <- "  markdown: default\n"
  # }
  #
  # # create string
  # readme_txt <- stringr::str_c("---\n",
  #                               "title: ", pkg_name, " package\n",
  #                               "author: ", author, "\n",
  #                               "date: today\n",
  #                               "date-format: \"DD/MM/YYYY\"\n",
  #                              "format:\n",
  #                               out_format,
  #                               "toc: true\n",
  #                               "editor_options:\n",
  #                               "  chunk_output_type: console\n",
  #                               "---\n",
  #                               "\n",
  #                               "## Introduction\n",
  #                               "README for ", pkg_name, " package.\n",
  #                              "\n",
  #                              "This should be edited manually with key info about the package.\n")
  #
  # # create qmd
  # cat(readme_txt,
  #     file = here::here("README.qmd"),
  #     sep = "\n")

  # # render Qmd
  # quarto::quarto_render("README.qmd",
  #                       quiet = TRUE)

}
