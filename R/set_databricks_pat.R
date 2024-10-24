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
  
  OrganicFarmingStats::print_message(type = "success",
                                     message = "Databricks PAT set to: {values[1]}",
                                     values = tmp)
  cli::cli_text("")
  
  # return
  tmp
}