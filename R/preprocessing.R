#' @rdname preprocessing
#' @export

# Remove carriage return and trim white spaces in subject line
trim_subject <- function(mbox_df) {
if(!inherits(mbox_df, "mbox_df")) {
stop("You need an mbox_df object for this function: Convert your mbox file through `read_mbox()` first.")
}

mbox_df %>%
dplyr::mutate(subject = stringr::str_replace_all(string = subject, pattern = "[[:cntrl:]]+", replacement = " ")) %>%
dplyr::mutate(subject = stringr::str_replace_all(string = subject, pattern = "[[:space:]]+", replacement = " "))
}

