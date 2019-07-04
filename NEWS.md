
# mboxr (development version)

* Non-ASCII decoding issue in the subject line has been resolved; you will no longer see `<environment>` for any non-ASCII subjects (thanks @carlmcqueen, #1).


# mboxr 0.1.5

* A functionality of saving an mbox file object as an Rda file in both `read_mbox()` and `merge_mbox_all()` has been replaced with saving it as an RDS.
* Some parameter names has changed to better reflect their usage in both `read_mbox()` and `merge_mbox_all()` functions (e.g., from `file` to `mbox`; and from `out` to `file`.
* New variables (i.e., columns) have been added to a returned mbox tibble data_frame object: message_ID; in_reply_to; and references. (Those are commonly used entries in mailing systems like Mailman).
* Underlying Python script now returns an mbox file name when an error occurs. Sometimes, a new line starting with non-escaped 'From ' in middle of message body causes an error; this does not have to do with this `mboxr` package; users have to manually modify their original mbox files by replacing a new line starting with 'From ' with '>From ' found in the middle of message body.


# mboxr 0.1.4

* Underlying Python code has been modified to address some critical issues that has caused errors when parsing "From," and "To" variables; this change will resolve any unexpected stops in `read_mbox()` and `merge_mbox_all()` functions.
* `read_mbox()` and `merge_mbox_all()` no longer saves an output as a CSV file since CSV format is not sufficient for handling a large amount of data and can even cause some issues; Rda file format is now supported instead.
* "cc" variable has newly been added to a returned tibble object for an mbox file.
* "date" variable is now automatically converted into `lubridate::as_datetime()` object with the default timezone as UTC.


# mboxr 0.1.3

* "UTF-8" has been applied to test mbox and Python files.
* Author field has been corrected in the Vignette.

# mboxr 0.1.2

* Example mbox files are added for testing purpose.
* New argument `path` is added for `merge_mbox_all()` function.
* A new column `to` is added for tibble output for a given mbox file.


# mboxr 0.1.1

* A new function `merge_mbox_all()` is added for merging all available mbox files in the current active directory into one mbox file as a tibble object.


# mboxr 0.1.0

* Added a `NEWS.md` file to track changes to the package.
* Initial release.
