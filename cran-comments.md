## Test environments
* local R installation, R 3.6.1
* ubuntu 16.04 (on travis-ci), R 3.6.1
* win-builder (devel)

## R CMD check results

0 errors | 0 warnings | 1 note

# mboxr 0.2.0

* `num_discussants` and `weekday` columns have been added to a tibble object created by `read_mbox()` function.
* Now the returned tibble object is automatically arranged by date column in the increasing order.
