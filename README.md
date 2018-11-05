mboxR
=====

The goal of mboxR is to allow R users to conveniently import an mbox
file into R data\_frame for hands-on analyses in R environment.

Installation
============

Python Dependencies
-------------------

`mboxR` requires Python 3.x on your system Path.

Please check whether Python 3.x is available on your system first, if
not, install Python version 3.x beforehand.

R Package Installation
----------------------

`mboxR` has not been submitted to CRAN. Please install the package using
`devtools` like below:

``` r
if(!require(devtools)) {
install.packages("devtools")
}

devtools::install_github("jooyoungseo/mboxR")
```

Usage
-----

Please use `mbox()` function after loading `mboxR` library like below:

``` r
library(mboxR)
# Importing your mbox file into an R:
data <- mbox("your_file.mbox")

# Or, you can save your mbox file as a CSV file while assigning a data_frame variable at the same time like below :
data <- mbox("your_file.mbox", "output.csv")
## Find your "output.csv" file saved in your computer while freely using the imported data_frame in your R session!
```
