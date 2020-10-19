#' @rdname preprocessing
#' @export

# Remove carriage return and trim white spaces in subject line
trim_subject <- function(df) {
df %>%
dplyr::mutate(subject = stringr::str_replace_all(string = subject, pattern = "[[:cntrl:]]+", replacement = " ")) %>%
dplyr::mutate(subject = stringr::str_replace_all(string = subject, pattern = "[[:space:]]+", replacement = " "))
}

