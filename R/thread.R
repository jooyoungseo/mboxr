#' num_thread
#' @title Counting the number of email thread.

#' @aliases num_thread
#' @keywords thread

#' @description A thread is defined as a message instance having more than 1 participants (i.e., num_discussants > 1).
#' @export num_thread
#' @param mbox_df Tibble mbox_df object.

#' @details
#' See example below.

#' @return Tibble data_frame (mbox_df) for input mbox file will be returned.

#' @examples
#' \donttest{
#' # Changing working directory to temp for the demonstration purpose only.
#' withr::with_tempdir(code = {
#'   library(mboxr)
#'   # Feeding an mbox file through read_mbox function:
#'   test <- system.file("extdata", "test1.mbox", package = "mboxr")
#'   data <- read_mbox(mbox = test, file = "output.rds")
#'   # Count the number of threads (i.e., message instance having num_discussants > 1).
#'   num_thread(data)
#' })
#' }
#'
#' @author JooYoung Seo, \email{jooyoung@psu.edu}
#' @author Soyoung Choi, \email{sxc940@psu.edu}

num_thread <- function(mbox_df) {
  mbox_df %>%
is_thread() %>%
sum(., na.rm = TRUE)
}


#' @rdname num_thread
#' @export

is_thread <- function(mbox_df) {
  #  checkMbox_df(mbox_df)["num_discussants"] > 1
  mbox_df$num_discussants > 1
}
