#' @title
#' Write data to the DASH Unity Catalog from RStudio cluster
#'
#' @author Josh Moatt
#'
#' @description
#' Currently the DASH Unity Catalog (UC) and RStudio server cannot directly
#' interact. So you must interact with the databricks API and copy data to the
#' DASH UC from the RStudio server. This is a simple function to save data from
#' the RStudio cluster onto databricks. It is built using the httr2 package and
#' uses a PUT request to save the data.
#'
#' Note, you must have set up a databricks PAT in the databricks settings before
#' doing this.
#'
#' @param workspace databricks workspace (string)
#'
#' @param volume path to folder on databricks where data should be written
#'   (string)
#'
#' @param token databricks PAT (string)
#'
#' @param file name of file to be exported including file extension. Will be
#'   used to both specify the file to export and specify the file to be created
#'   on databricks (String).
#'
#' @param folder path to folder on RStudio Cluster that contains data to export.
#'
#' @return
#' data saved in Rstudio cluster.
#'
#' @export
uc_volume_put <- function(workspace,
                          volume,
                          token,
                          file,
                          folder) {

  ## set up ----

  # create URL
  url <- glue::glue("{workspace}/api/2.0/fs/files/{volume}/{file}")

  # combine folder and file to get out_file
  out_file <- glue::glue("{folder}/{file}")

  ## write data to data bricks ----

  response <- httr2::request(url) %>%
    httr2::req_method("PUT") %>% # PUT request seems to work best
    httr2::req_headers(
      Authorization = glue('Bearer {token}'), # use data bricks PAT
      `Content-Type` = 'multipart/form-data' # may need to incorporate other file types long-term
    ) %>%
    httr2::req_body_file(out_file) %>% # specifies file to export
    httr2::req_perform()
}
