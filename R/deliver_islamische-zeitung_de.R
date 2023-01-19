
pb_deliver_paper.www_islamische-zeitung_de <- function(x, verbose = NULL, ...) {

  . <- NULL

  if (is.null(verbose)) verbose <- getOption("paperboy_verbose")

  class_test(x)

  if (verbose) message("\t...", nrow(x), " articles from ", x$domain[1])

  pb <- make_pb(x)

  purrr::map_df(x$content_raw, function(cont) {

    if (verbose) pb$tick()

    html <- rvest::read_html(cont)

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
