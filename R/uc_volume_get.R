#' @title
#' Pull data from the DASH Unity Catalog into an RStudio cluster
#'
#' @author Josh Moatt
#'
#' @description
#' Currently the DASH Unity Catalog (UC) and RStudio cserver cannot directly
#' interact. So you must itneract with the databricks API and copy data from
#' DASH UC to the RStudio server. This is a simple function to read data from UC
#' into RStudio cluster on databricks.
#'
#' Note, you must have set up a databricks PAT in the databricks settings before
#' doing this.
#'
#' @param workspace databricks workspace (string)
#'
#' @param volume file path to data folder (string)
#'
#' @param token databricks PAT (string)
#'
#' @param out_file filepath in RCluster that data should be stored.
#'
#' @return
#' data saved in Rstudio cluster.
#'
#' @export
uc_volume_get <- function(workspace,
                          volume,
                          token,
                          out_file) {
  # set URL
  url <- glue::glue("{workspace}/api/2.0/fs/files/{volume}")

  # set header (with DataBricks PAT)
  headers <- httr::add_headers('Authorization' = glue::glue('Bearer {token}'))


  # make the GET request
  response <- httr::GET(url,
                        headers,
                        httr::write_disk(out_file,
                                         overwrite = TRUE))

  # Extract content from the response
  httr::stop_for_status(response)

}
