# To run:
# source("https://raw.githubusercontent.com/biodash/biodash.github.io/master/assets/scripts/birds/CC01_setup.R")

# Create an RStudio project -------------------------------------

# if (!any(str_detect(list.files(), ".*.Rproj"))) {
#   message("\n-> Creating an RStudio project in the current directory...")
#   message("-> First loading/installing the usethis package...")
#   if (!require("usethis")) install.packages("usethis")
#   library(usethis)
#   create_project(path = getwd(), open = FALSE)
# } else {
#   message("\n-> An RStudio project already exists in the current directory: nothing was done.")
# }


# Set-up ---------------------------------------------------------

# Load the tidyverse meta-package:
message("\n-> Loading/installing the tidyverse...")
if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)

# If the bird data dir does not exist, create it:
data_dir <- "data/birds"

if (!dir.exists(data_dir)) {
  message(paste("\n-> Creating the dir", data_dir))
  dir.create(data_dir, recursive = TRUE)
} else {
  message(paste("\n-> The dir", data_dir, "already exists, nothing was done."))
}


# Getting the bird data -----------------------------------------

# The URL to our file:
birds_file_url <- "https://raw.githubusercontent.com/biodash/biodash.github.io/master/assets/data/birds/backyard-birds_Ohio.tsv"

# The path to the file we want to download to:
birds_file <- "data/birds/backyard-birds_Ohio.tsv"

# Download the file if it doesn't exist already:
if (!file.exists(birds_file)) {
  message(paste("\n-> Downloading the bird data into", birds_file))
  download.file(url = birds_file_url, destfile = birds_file)
} else {
  message(paste("\n-> The file", birds_file, "already exists: nothing was done."))
}


# Reading the bird data -----------------------------------------

# message("\nReading the bird data...")
# birds <- read_tsv(file = birds_file)
