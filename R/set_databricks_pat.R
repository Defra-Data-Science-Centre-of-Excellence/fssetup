#' @title
#' Set databricks PAT
#'
#' @author Josh Moatt
#'
#' @description
#' Simple function to set databricks PAT. Done via function to avoid committing to GitHub
#' accidentally.
#'
#' @return
#' databricks PAT written to environment
#'
#' @export
set_databricks_pat <- function() {
  tmp <- readline("Please enter your databricks PAT: \n")

  cli::cli_alert_success("Databricks PAT set to: {tmp}")
  cli::cli_text("")

  # return
  tmp
}
