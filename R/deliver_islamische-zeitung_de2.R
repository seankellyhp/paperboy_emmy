#' internal function to deliver specific newspapers
#' @param x A data.frame returned by  \link{pb_collect} with an additional class
#'   indicating the domain of all links.
#' @inheritParams pb_deliver
#' @keywords internal
deliver_islamische_zeitung_de <- function(x, verbose = NULL, ...) {
  
  # If verbose is not explicitly defined, use package default stored in options.
  if (is.null(verbose)) verbose <- getOption("paperboy_verbose")
  
  class_test(x)
  
  if (verbose) message("\t...", nrow(x), " articles from ", x$domain[1])
  
  # helper function to make progress bar
  pb <- make_pb(x)
  
  # iterate over all URLs and normalise data.frame
  purrr::map_df(x$content_raw, parse_islamische_zeitung_de, verbose, pb) %>%
    cbind(x) %>%
    normalise_df() %>%
    return()
  
}

# define parsing function to iterate over the URLs
parse_islamische_zeitung_de <- function(html, verbose, pb) {
  
  # raw html is stored in column content_raw
  html <- rvest::read_html(html)
  if (verbose) pb$tick()
  
  # datetime
  datetime <- html %>%
    rvest::html_nodes(".published") %>%
    rvest::html_text() %>%
    lubridate::as_datetime(format = '%d.%m.%Y')
  
  # headline
  headline <- html %>%
    rvest::html_nodes(".iz-heading--entry") %>%
    rvest::html_text()
  
  # author
  author <- html %>%
    rvest::html_nodes(".iz-author__name") %>%
    rvest::html_text()
  
  # text
  text <- html %>%
    rvest::html_elements(".entry-content") %>%
    rvest::html_elements("p") %>%
    rvest::html_text2() %>%
    paste(collapse = "\n")
  
  # the helper function safely creates a named list from objects
  s_n_list(
    datetime,
    author,
    headline,
    text
  )
  
}