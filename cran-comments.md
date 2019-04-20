## Test environments
* local OS X install, R 3.5.3
* ubuntu 14.04 (on travis-ci), R 3.5.3
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

# mboxr 0.1.5

* A functionality of saving an mbox file object as an Rda file in both `read_mbox()` and `merge_mbox_all()` has been replaced with saving it as an RDS.
* Some parameter names has changed to better reflect their usage in both `read_mbox()` and `merge_mbox_all()` functions (e.g., from `file` to `mbox`; and from `out` to `file`.
* New variables (i.e., columns) have been added to a returned mbox tibble data_frame object: message_ID; in_reply_to; and references. (Those are commonly used entries in mailing systems like Mailman).
* Underlying Python script now returns an mbox file name when an error occurs. Sometimes, a new line starting with non-escaped 'From ' in middle of message body causes an error; this does not have to do with this `mboxr` package; users have to manually modify their original mbox files by replacing a new line starting with 'From ' with '>From ' found in the middle of message body.
