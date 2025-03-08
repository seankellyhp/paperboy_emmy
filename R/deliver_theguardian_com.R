
pb_deliver_paper.www_theguardian_com <- function(x, verbose = NULL, ...) {

  . <- NULL

  class_test(x)

  if (is.null(verbose)) verbose <- getOption("paperboy_verbose")

  if (verbose) message("\t...", nrow(x), " articles from ", x$domain[1])

  pb <- make_pb(x)

  purrr::map_df(x$content_raw, function(cont) {

    if (verbose) pb$tick()

    html <- rvest::read_html(cont)

    # datetime
    datetime <- html %>%
      rvest::html_elements("[property=\"article:published_time\"]") %>%
      rvest::html_attr("content") %>%
      lubridate::as_datetime()

    # headline
    headline <- html %>%
      rvest::html_elements("[property=\"og:title\"]") %>%
      rvest::html_attr("content")

    # author
    author <- html %>%
      rvest::html_elements("[property=\"article:author\"]") %>%
      rvest::html_attr("content")

    if (length(author) == 0) {
      author <- html %>%
        rvest::html_elements("[name=\"author\"]") %>%
        rvest::html_attr("content")
    }

    if (length(author) > 1) author <- toString(author)

    # text
    text <- html %>%
      rvest::html_elements("p") %>%
      rvest::html_text2() %>%
      paste(collapse = "\n")

    s_n_list(
      datetime,
      author,
      headline,
      text
    )
  }) %>%
    cbind(x) %>%
    normalise_df() %>%
    return()
}
