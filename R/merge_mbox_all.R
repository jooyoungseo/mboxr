#' merge_mbox_all
#' @title Merging all mbox files in current directory into one tibble.

#' @aliases merge_mbox_all
#' @keywords merge_mbox_all

#' @description Use this function for merging all mbox files into one tibble object.
#' @export merge_mbox_all
#' @param path A character vector of full path names; the default corresponds to the working directory, \link[base]{getwd}. Tilde expansion (see \link[base]{path.expand}) is performed. Missing values will be ignored.
#' @param file Output RDS file if you want to save. The default is NULL, which is not saving the output as a file.

#' @details
#' See example below.

#' @return One tibble object for all the merged mbox files in your current directory will be returned.

#' @examples
#' \donttest{
#' # Changing working directory to temp for the demonstration purpose only.
#' withr::with_tempdir(code = {
#'   library(mboxr)
#'   test_path <- system.file("extdata", package = "mboxr")
#'   # Save your own RDS file as an output if you need it:
#'   data <- merge_mbox_all(path = test_path, file = file.path(tempdir(), "output.rds"))
#'   # Now you can use the imported file as a tibble.
#'   str(data)
#' })
#' }
#'
#' @author JooYoung Seo, \email{jooyoung@psu.edu}
#' @author Soyoung Choi, \email{sxc940@psu.edu}

#' @references \url{https://en.wikipedia.org/wiki/Mbox}
#' @references \url{https://docs.python.org/3/library/mailbox.html}
#' @references \url{https://www.anaconda.com/download/}

merge_mbox_all <-
  function(path = ".", file = NULL) { # Function starts:

    if (length(list.files(path, pattern = "(*.mbox)$")) > 0) {
      if (path != ".") {
        current_wd <- getwd()
        setwd(path)
      }

      multi_mbox <- list.files(path, pattern = "(*.mbox)$") %>%
        purrr::map_df(~ mboxr::read_mbox(.))

      if (path != ".") {
        setwd(current_wd)
      }

      if (!is.null(file)) {
        fileExt <- tolower(tools::file_ext(file))
        if (fileExt == "") {
          saveRDS(multi_mbox, file = paste0(file, ".rds"))
        } else if (fileExt == "rds") {
          saveRDS(multi_mbox, file = file)
        } else {
          warning("Something is wrong with your output file name. Currently 'RDS' format is only supported.")
        }
      }

      return(multi_mbox)
    } else {
      stop("No mbox file is found in the current directory.")
    }
  } # Function ends.
