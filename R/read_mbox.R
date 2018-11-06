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
#' library(mboxR)
#' # Feeding an mbox file through read_mbox function:
#' data <- read_mbox("input.mbox", out = "output.csv")
#' # Now you can use the imported file as a data_frame.
#' str(data)
#'}

#' @author JooYoung Seo (jooyoung@psu.edu)

read_mbox <- 
function(file, out=NULL) {   # Function starts:

	if(reticulate::py_available(initialize=T)) {
		if(reticulate::py_config()$version > 3) {
			reticulate::source_python(system.file("python/mboxR.py", package="mboxR"))
			df = mbox_df(file)
			df <- dplyr::data_frame(date = as.character(df$date), from = as.character(df$from), subject = as.character(df$subject), content = as.character(df$content))
			if(!is.null(out)) {
				readr::write_csv(df, out)
			}
			return(df)
		} else {
			stop("Please use Python version 3.x instead of 2.x.")
		}
	} else {
		stop("Python has not been found in your system Path. Please install Python (Version 3.x) and add the installed directory to your system Path.")
	}

}   # Function ends.
