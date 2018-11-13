merge_mbox_all <-
function(out = NULL) {   # Function starts:

	multi_mbox <- list.files(pattern = "*.mbox") %>% 
		purrr::map_df(~mboxr::read_mbox(.))

	if(!is.null(out)) {
		readr::write_csv(multi_mbox, out)
	}

}   # Function ends.
