mboxr
=====

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/mboxr)](https://cran.r-project.org/package=mboxr)
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
[**pandas.DataFrame**](https://pandas.pydata.org/), and
[**email.header.decode\_header**](https://docs.python.org/3/library/email.header.html)
Python modules into R using
[**reticulate**](https://rstudio.github.io/reticulate/).

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
str(data)
#> Classes 'tbl_df', 'tbl' and 'data.frame':    2 obs. of  5 variables:
#>  $ date   : chr  "Fri Jul  8 12:08:34 2011" "Fri Jul  8 12:08:34 2011"
#>  $ from   : chr  "author@example.com" "author@example.com"
#>  $ to     : chr  "recipient@example.com" "recipient@example.com"
#>  $ subject: chr  "Sample message 1" "Sample message 2"
#>  $ content: chr  "This is the body.\n>From (should be escaped).\nThere are 3 lines.\n" "This is the second body.\n"

# Or, you can save your mbox file as an Rda file while assigning a tibble variable at the same time like below:
data <- read_mbox(test, "output.Rda")
data
#> # A tibble: 2 x 5
#>   date         from       to         subject    content                    
#>   <chr>        <chr>      <chr>      <chr>      <chr>                      
#> 1 Fri Jul  8 ~ author@ex~ recipient~ Sample me~ "This is the body.\n>From ~
#> 2 Fri Jul  8 ~ author@ex~ recipient~ Sample me~ "This is the second body.\~

# You can merge all mbox files in your current directory or in any specified path into one tibble and save as an Rda file for the integrated one:
test_path <- system.file("extdata", package = "mboxr")
all_data <- merge_mbox_all(path = test_path, out = "all_merged_mbox.Rda")
## Find your "output.Rda" file saved in your working directory while freely using the imported tibble in your R session!
all_data
#> # A tibble: 4 x 5
#>   date         from      to         subject      content                   
#>   <chr>        <chr>     <chr>      <chr>        <chr>                     
#> 1 Fri Jul  8 ~ author@e~ recipient~ Sample mess~ "This is the body.\n>From~
#> 2 Fri Jul  8 ~ author@e~ recipient~ Sample mess~ "This is the second body.~
#> 3 Sat Jul  9 ~ author@e~ recipient~ Another sam~ "R is the best!\nLet's us~
#> 4 Sun Jul  10~ author@e~ recipient~ The last sa~ "This is the last message
```
