# Rtreasuryio
_Access [treasury.io](http://treasury.io) from `R`_

This is a package consisting of a single, simple function for submitting `SQL` queries to [treasury.io](http://treasury.io) from `R`. While you could simply copy-and-paste the function from script-to-script, this makes it quicker and easier to get up and running!

## Installation
```
library('devtools')
install_github('Rtreasuryio', 'csvsoundsystem')
library('Rtreasuryio')
```

## Example
```
# Operating cash balances for May 22, 2013
sql <- 'SELECT * FROM "t1" WHERE "date" = \'2013-05-22\';'
treasuryio(sql)
```

## Source Code
```
library(plyr)
library(utils)
library(RJSONIO)
library(RCurl)

treasuryio <- function(sql) {
  url = paste('http://api.treasury.io/cc7znvq/47d80ae900e04f2/sql/?q=', URLencode(sql), sep = '')
  handle <- getCurlHandle()
  body <- getURL(url, curl = handle)
  if (200 == getCurlInfo(handle)$response.code) {
    ldply(
      fromJSON(body),
      function(row) {as.data.frame(t(row))}
    )
  } else {
    stop(body)
  }
}
```
