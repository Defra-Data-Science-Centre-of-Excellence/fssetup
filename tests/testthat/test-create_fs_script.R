test_that("create_fs_script creates script", {

  # create temp dir
  temp_dir <- tempdir()

  # expected file
  expected_file <- file.path(temp_dir, "test-script.R")

  # function
  create_fs_script(file_name = "test-script",
                   file_path = temp_dir)

  # check file exists
  expect_true(file.exists(expected_file))

  unlink(expected_file)
})
