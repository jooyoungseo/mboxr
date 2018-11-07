#' read_mbox
#' @title Converting an mbox file into a data_frame.

#' @aliases read_mbox
#' @keywords read_mbox

#' @description Use this function for importing and converting an mbox file into a data_frame object.
#' @export read_mbox
#' @param file Input mbox file.
#' @param out Output CSV file if you want to save. The default is NULL, which is not saving the output as a file.

#' @details
#' See example below.

#' @return data_frame object for the input mbox file will be returned.

#' @examples

#'\dontrun{
#' library(mboxr)
#' # Feeding an mbox file through read_mbox function:
#' data <- read_mbox("input.mbox", out = "output.csv")
#' # Now you can use the imported file as a data_frame.
#' str(data)
#'}

#' @author JooYoung Seo (jooyoung@psu.edu)

read_mbox <- 
function(file = NULL, out=NULL) {   # Function starts:

	envnm <- 'mboxr'

	tryCatch({
		if (!(envnm %in% reticulate::conda_list()$name)) {
			reticulate::conda_create(envnm, packages = c("python=3.6", "pandas"), conda = "auto")
		}
	},
	error = function(e) {
		stop("Need to install Anaconda from https://www.anaconda.com/download/.")
	},
	finally = {
		reticulate::use_condaenv(envnm, required = TRUE)
			if (!reticulate::py_module_available("pandas")) {
				reticulate::conda_install(envnm, packages = c('pandas'))
			}

			if (!reticulate::py_module_available("mailbox")) {
				reticulate::conda_install(envnm, packages = c('mailbox'))
			}

			if (!reticulate::py_module_available("email")) {
				reticulate::conda_install(envnm, packages = c('email'))
			}
	})

	df <- reticulate::py_run_file(system.file("python/mboxr.py", package="mboxr"))$mbox_df(file)
	df <- dplyr::data_frame(date = as.character(df$date), from = as.character(df$from), subject = as.character(df$subject), content = as.character(df$content))
	if(!is.null(out)) {
		readr::write_csv(df, out)
	}
	return(df)

}   # Function ends.
