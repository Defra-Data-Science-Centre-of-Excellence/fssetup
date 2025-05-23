#' @title Customise RStudio IDE layout
#'
#' @author Josh Moatt
#'
#' @description Simple function I created to customise the RStudio IDE. Maks
#' setting up RStudio on DASH much easier and quicker following a cluster
#' restart.
#'
#' @param ... Named arguments representing RStudio preferences to be updated.
#'   Each argument should be named after an RStudio preference and assigned the
#'   desired value.
#'
#' @return The function modifies RStudio preferences as a side effect.
#'
#' @examples
#' \dontrun{
#' # set pane layout
#' my_pane_layout <- list(
#'   quadrants = list("Source", "TabSet1", "Console", "TabSet2"),
#'   tabSet1 = list("History", "Presentation"),
#'   tabSet2 = list("Environment", "Files", "Plots", "Connections", "Packages", "Help", "Build", "VCS", "Tutorial", "Viewer", "Presentations"),
#'   hiddenTabSet = list(),
#'   console_left_on_top = FALSE,
#'   console_right_on_top = TRUE,
#'   additional_source_columns = 0
#' )
#'
#' # apply preferences
#' customise_layout(
#'   always_save_history = FALSE, # don't auto save history
#'   save_workspace = "never", # don't save workspace
#'   load_workspace = FALSE, # don't load previous workspace
#'   restore_last_project = FALSE, # don't restore last opened project
#'   continue_comments_on_newline = TRUE, # when commenting, hitting enter continues comment on new line
#'   highlight_selected_line = FALSE, # highlight line cursor is on
#'   highlight_r_function_calls = TRUE, # highlight R function calls
#'   show_margin = FALSE, # don't show margin (default = 80 characters)
#'   rainbow_parentheses = TRUE, # colour match brackets
#'   color_preview = TRUE, # hexcode previews on
#'   panes = my_pane_layout # Pane layout as set above
#' )
#' }
#'
#' @export
customise_layout <- function(...){
  list_updated_prefs <- rlang::dots_list(...)


  # pull a list of current preferences based on the updates we want to make
  list_current_prefs <- names(list_updated_prefs) |>
    purrr::map(~rstudioapi::readRStudioPreference(.x, default = NULL)) |>
    stats::setNames(names(list_updated_prefs)) |>
    purrr::compact()

  # overwirte exisitng preferences and safe
  list_updated_prefs |>
    purrr::iwalk(~rstudioapi::writeRStudioPreference(name = .y, value = .x))
}
