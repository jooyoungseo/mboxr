mboxr
=====

The goal of mboxr is to allow R users to conveniently import an mbox
file into R data\_frame for hands-on analyses in R environment.

Installation
============

Python Dependencies
-------------------

`mboxr` requires Python 3.x on your system Path.

Please check whether Python 3.x is available on your system first, if
not, install Python version 3.x beforehand.

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

You can install the released version of ezpickr from
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
data <- read_mbox("your_file.mbox")

# Or, you can save your mbox file as a CSV file while assigning a data_frame variable at the same time like below :
data <- read_mbox("your_file.mbox", "output.csv")
## Find your "output.csv" file saved in your computer while freely using the imported data_frame in your R session!
```
