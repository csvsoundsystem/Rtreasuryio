#' submit a sql query to treasury.io and return a data.frame
#'
#' @param sql a string representing your sql query
#'
#' @return
#' a data.frame consisting of your query results.
#'
#' @export
#'
#' @examples
#' print('Operating cash balances for May 22, 2013')
#' print(treasury.io('SELECT * FROM "t1" WHERE "date" = \'2013-05-22\';'))
library(plyr)
library(utils)
library(RJSONIO)
library(RCurl)

treasuryio <- function(sql) {
  url = paste('https://premium.scraperwiki.com/cc7znvq/47d80ae900e04f2/sql/?q=', URLencode(sql), sep = '')
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
