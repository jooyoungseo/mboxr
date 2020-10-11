#' read_mbox
#' @title Converting an mbox file into a tibble data_frame.

#' @aliases read_mbox
#' @keywords read_mbox

#' @description Use this function for importing and converting an mbox file into a tibble object.
#' @export read_mbox
#' @param mbox Input mbox file.
#' @param file Output RDS file if you want to save. The default is NULL, which is not saving the output as a file.

#' @details
#' See example below.

#' @return Tibble object for the input mbox file will be returned.

#' @examples
#' \donttest{
#' # Changing working directory to temp for the demonstration purpose only.
#' withr::with_tempdir(code = {
#'   library(mboxr)
#'   # Feeding an mbox file through read_mbox function:
#'   test <- system.file("extdata", "test1.mbox", package = "mboxr")
#'   data <- read_mbox(mbox = test, file = "output.rds")
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

read_mbox <-
  function(mbox = NULL, file = NULL) { # Function starts:

    if (is.null(mbox) || tools::file_ext(mbox) != "mbox") {
      stop("Please pass an mbox file for the first argument.")
    }

    envnm <- "mboxr"

    tryCatch(
      {
        if (!(envnm %in% reticulate::conda_list()$name)) {
          reticulate::conda_create(envnm, packages = c("python=3.7.3", "pandas"), conda = "auto")
        }
      },
      error = function(e) {
        stop("Need to install Anaconda from https://www.anaconda.com/download/.")
      },
      finally = {
        reticulate::use_condaenv(envnm, required = TRUE)
        if (!reticulate::py_module_available("pandas")) {
          reticulate::conda_install(envnm, packages = c("pandas"))
        }

        if (!reticulate::py_module_available("mailbox")) {
          reticulate::conda_install(envnm, packages = c("mailbox"))
        }

        if (!reticulate::py_module_available("email")) {
          reticulate::conda_install(envnm, packages = c("email"))
        }
      }
    )

    df <- reticulate::import_from_path(module = "mboxR", path = system.file("python", package = "mboxr"), convert = TRUE)$mbox_df(mbox)
    df <- dplyr::na_if(tibble::tibble(date = as.character(df$date), message_ID = as.character(df$message_ID), in_reply_to = as.character(df$in_reply_to), references = as.character(df$references), from = as.character(df$from), to = as.character(df$to), cc = as.character(df$cc), subject = as.character(df$subject), content = as.character(df$content)), "NULL") %>%
      dplyr::mutate(date = lubridate::as_datetime(df$date))
    df <- df %>%
      dplyr::mutate(num_discussants = tidyr::replace_na((1 + stringr::str_count(df$references, "@")), 1)) %>%
      dplyr::mutate(weekday = lubridate::wday(df$date, label = TRUE)) %>%
      dplyr::arrange(date)

    if (!is.null(file)) {
      fileExt <- tolower(tools::file_ext(file))
      if (fileExt == "") {
        saveRDS(df, file = paste0(file, ".rds"))
      } else if (fileExt == "rds") {
        saveRDS(df, file = file)
      } else {
        warning("Something is wrong with your output file name. Currently only 'RDS' format is supported.")
      }
    }
    return(df)
  } # Function ends.
