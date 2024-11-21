#' @title
#' function for creating a tempfile when exporting data to DASH
#'
#' @author Josh Moatt
#'
#' @description
#' Very simple function to aid in exporting an object from the R environment on
#' a DASH RStudio cluster to the databricks filestore. Desingned to be used
#' alongside the function {db_volume_write} from the `brickster` package.
#'
#' @param object object from R environment to export. So far works with all
#'   types (e.g. data.frame, openxlsx workbook etc).
#'
#' @param file_type string  specifying file type of the tempfile. Can be "rds",
#'   "xlsx" or "csv". Other types can be added to the function if needed.
#'
#' @return
#' a tempfile with specified extension.
#'
#' @export
temp_file <- function(object, file_type) {

  # set method to save
  save_type <- switch(
    file_type,
    "rds" = saveRDS,
    "xlsx" = openxlsx::saveWorkbook,
    "csv" = readr::write_csv
  )

  # create temp_file
  temp <- tempfile()

  # add data to tempfile
  save_type(
    object,
    temp
  )

  # return path
  return(temp)
}
