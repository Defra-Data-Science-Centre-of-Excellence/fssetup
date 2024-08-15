test_that("create_fs_readme creates .qmd and .html", {

  # create temp dir
  temp_dir <- tempdir()

  # expected file extensions
  expected_files <- c("README.qmd", "README.html")

  # expected paths
  expected_paths <- file.path(temp_dir, expected_files)

  # function
  create_fs_readme(format = "html",
                   file_path = temp_dir)

  # check file exists
  expect_true(all(file.exists(expected_paths)), info = ".qmd and .html should exist after call.")

  unlink(expected_paths)

})

test_that("create_fs_readme creates .qmd and .md", {

  # create temp dir
  temp_dir <- tempdir()

  # expected file extensions
  expected_files <- c("README.qmd", "README.md")

  # expected paths
  expected_paths <- file.path(temp_dir, expected_files)

  # function
  create_fs_readme(format = "markdown",
                   file_path = temp_dir)

  # check file exists
  expect_true(all(file.exists(expected_paths)), info = ".qmd and .md should exist after call.")

  unlink(expected_paths)

})

test_that("create_fs_readme creates .qmd and github .md", {

  # create temp dir
  temp_dir <- tempdir()

  # expected file extensions
  expected_files <- c("README.qmd", "README.md")

  # expected paths
  expected_paths <- file.path(temp_dir, expected_files)

  # function
  create_fs_readme(format = "github",
                   file_path = temp_dir)

  # check file exists
  expect_true(all(file.exists(expected_paths)), info = ".qmd and .md should exist after call.")

  unlink(expected_paths)

})
