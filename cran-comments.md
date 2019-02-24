## Test environments
* local OS X install, R 3.5.2
* ubuntu 14.04 (on travis-ci), R 3.5.2
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

# mboxr 0.1.4

* Underlying Python code has been modified to address some critical issues that has caused errors when parsing "From," and "To" variables; this change will resolve any unexpected stops in `read_mbox()` and `merge_mbox_all()` functions.
* `read_mbox()` and `merge_mbox_all()` no longer saves an output as a CSV file since CSV format is not sufficient for handling a large amount of data and can even cause some issues; Rda file format is now supported instead.
* "cc" variable has newly been added to a returned tibble object for an mbox file.
* "date" variable is now automatically converted into `lubridate::as_datetime()` object with the default timezone as UTC.
