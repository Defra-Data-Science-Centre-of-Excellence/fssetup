test_that("create_fs_gitignore creates expected file", {

  # create temp dir
  temp_dir <- tempdir()

  # expected file
  expected_file <- file.path(temp_dir, ".gitignore")

  # function
  create_fs_gitignore(file_path = temp_dir)

  # check file exists
  expect_true(file.exists(expected_file))

  unlink(expected_file)
})
