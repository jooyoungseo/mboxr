#' merge_mbox_all
#' @title Merging all mbox files in current directory into one tibble.

#' @aliases merge_mbox_all
#' @keywords merge_mbox_all

#' @description Use this function for merging all mbox files into one tibble object.
#' @export merge_mbox_all
#' @param out Output CSV file if you want to save. The default is NULL, which is not saving the output as a file.

#' @details
#' See example below.

#' @return One tibble object for all the merged mbox files in your current directory will be returned.

#' @examples

#'\dontrun{
#' library(mboxr)
#' # Save your own csv file as an output if you need it:
#' data <- merge_mbox_all(out = "output.csv")
#' # Now you can use the imported file as a data_frame.
#' str(data)
#'}

#' @author JooYoung Seo (jooyoung@psu.edu)

merge_mbox_all <-
function(out = NULL) {   # Function starts:

	if(length(list.files(pattern = "*.mbox")) > 0) {
		multi_mbox <- list.files(pattern = "*.mbox") %>% 
			purrr::map_df(~mboxr::read_mbox(.))

		if(!is.null(out)) {
			readr::write_csv(multi_mbox, out)
		}

		return(multi_mbox)
	} else {
		stop("No mbox file is found in the current directory.")
	}
}   # Function ends.
