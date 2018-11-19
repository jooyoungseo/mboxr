#' read_mbox
#' @title Converting an mbox file into a tibble data_frame.

#' @aliases read_mbox
#' @keywords read_mbox

#' @description Use this function for importing and converting an mbox file into a tibble object.
#' @export read_mbox
#' @param file Input mbox file.
#' @param out Output CSV file if you want to save. The default is NULL, which is not saving the output as a file.

#' @details
#' See example below.

#' @return Tibble object for the input mbox file will be returned.

#' @examples
#' library(mboxr)
#' # Feeding an mbox file through read_mbox function:
#' test <- system.file("extdata", "test1.mbox", package = "mboxr")
#' data <- read_mbox(test, out = "output.csv")
#' # Now you can use the imported file as a tibble.
#' str(data)

#' @author JooYoung Seo, \email{jooyoung@psu.edu}

#' @references \url{https://en.wikipedia.org/wiki/Mbox}
#' @references \url{https://docs.python.org/3/library/mailbox.html}
#' @references \url{https://www.anaconda.com/download/}

read_mbox <- 
function(file = NULL, out=NULL) {   # Function starts:

	if(is.null(file) || tools::file_ext(file) != "mbox") {
		stop("Please pass an mbox file as the first argument.")
	}

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

	df <- reticulate::import_from_path(module = "mboxR", path = system.file("python", package="mboxr"))$mbox_df(file)
	df <- tibble::tibble(date = as.character(df$date), from = as.character(df$from), to = as.character(df$to), subject = as.character(df$subject), content = as.character(df$content))
	if(!is.null(out)) {
		readr::write_csv(df, out)
	}
	return(df)

}   # Function ends.
