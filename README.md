mboxr
=====

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/mboxr)](https://cran.r-project.org/package=mboxr)
[![Total
Downloads](https://cranlogs.r-pkg.org/badges/grand-total/mboxr?color=orange)](https://cranlogs.r-pkg.org/badges/grand-total/mboxr)
[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
[![Travis build
status](https://travis-ci.org/jooyoungseo/mboxr.svg?branch=master)](https://travis-ci.org/jooyoungseo/mboxr)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/jooyoungseo/mboxr?branch=master&svg=true)](https://ci.appveyor.com/project/jooyoungseo/mboxr)
[![Codecov test
coverage](https://codecov.io/gh/jooyoungseo/mboxr/branch/master/graph/badge.svg)](https://codecov.io/gh/jooyoungseo/mboxr?branch=master)
<!-- badges: end -->

The goal of mboxr is to allow R users to conveniently import an [**mbox
file**](https://en.wikipedia.org/wiki/Mbox) into [**R
tibble**](https://tibble.tidyverse.org/) for hands-on analyses in R
environment.

Installation
============

Python Dependencies
-------------------

`mboxr` requires Anaconda Python environment on your system Path.

If you have not installed Conda environment on your system, please
[download and install Anaconda](https://www.anaconda.com/download/)
(Python 3.6 or later is recommended).

For this package, I have implemented
[**mailbox.mbox**](https://docs.python.org/3/library/mailbox.html),
[**email.header.decode\_header**](https://docs.python.org/3/library/email.header.html),
[**email.utils**](https://docs.python.org/3/library/email.utils.html)
and [**pandas.DataFrame**](https://pandas.pydata.org/) Python modules
into R using [**reticulate**](https://rstudio.github.io/reticulate/).

R Package Installation
----------------------

### Development Version

You can install the latest development version as follows:

``` r
if(!require(devtools)) {
install.packages("devtools")
}

devtools::install_github("jooyoungseo/mboxr")
```

### Stable Version

You can install the released version of mboxr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages('mboxr')
```

Usage
-----

Please use `read_mbox()` function after loading `mboxr` library like
below:

``` r
library(mboxr)
# Importing your mbox file into an R:
test <- system.file("extdata", "test1.mbox", package = "mboxr")
data <- read_mbox(test)
data
# > # A tibble: 2 x 6 > date from to cc subject content > <dttm> <chr> <chr>
# <chr> <chr> <chr> > 1 2011-07-08 12:08:34 Author <~ Recipient~ <NA> Sample
# ~ 'This is the bod~ > 2 2011-07-08 12:08:34 Author <~ Recipient~ <NA>
# Sample ~ 'This is the sec~

# Or, you can save your mbox file as an RDS file while assigning a tibble
# variable at the same time like below:
data <- read_mbox(mbox = test, file = "output.rds")
data
# > # A tibble: 2 x 6 > date from to cc subject content > <dttm> <chr> <chr>
# <chr> <chr> <chr> > 1 2011-07-08 12:08:34 Author <~ Recipient~ <NA> Sample
# ~ 'This is the bod~ > 2 2011-07-08 12:08:34 Author <~ Recipient~ <NA>
# Sample ~ 'This is the sec~

# You can merge all mbox files in your current directory or in any specified
# path into one tibble and save as an RDS file for the integrated one:
test_path <- system.file("extdata", package = "mboxr")
all_data <- merge_mbox_all(path = test_path, file = "all_merged_mbox.rds")
## Find your 'output.rds' file saved in your working directory while freely
## using the imported tibble in your R session!

all_data
# > # A tibble: 4 x 6 > date from to cc subject content > <dttm> <chr> <chr>
# <chr> <chr> <chr> > 1 2011-07-08 12:08:34 Author <~ Recipient~ <NA> Sample
# m~ 'This is the bo~ > 2 2011-07-08 12:08:34 Author <~ Recipient~ <NA>
# Sample m~ 'This is the se~ > 3 2011-07-09 12:09:35 Author <~ Recipient~
# <NA> Another ~ 'R is the best!~ > 4 2011-07-10 10:03:32 Author <~
# Recipient~ <NA> The last~ 'This is the la~
```
