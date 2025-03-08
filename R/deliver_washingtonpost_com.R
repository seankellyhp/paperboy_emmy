
#' @keywords internal
pb_deliver_paper.www_washingtonpost_com <- function(x, verbose = NULL, ...) {

  . <- NULL

  if (is.null(verbose)) verbose <- getOption("paperboy_verbose")

  class_test(x)

  if (verbose) message("\t...", nrow(x), " articles from ", x$domain[1])

  pb <- make_pb(x)

  purrr::map_df(seq_along(x$url), function(i) {
    if (basename(x$expanded_url[i]) == x$domain[i]) {

      if (verbose) pb$tick()

      tibble::tibble(
        datetime  = NA,
        author    = NA,
        headline  = NA,
        text      = NA
      )

    } else {

      cont <- x$content_raw[i]
      if (verbose) pb$tick()

      html <- rvest::read_html(cont)

      # datetime
      suppressWarnings(
        datetime <- html %>%
          rvest::html_elements("[property=\"article:published_time\"],[itemprop*=\"datePublished\"],[name=\"ga-publishDate\"]") %>%
          rvest::html_attr("content") %>%
          lubridate::as_datetime()
      )

      if (length(datetime) < 1) {
        datetime <- html %>%
          rvest::html_elements("[class*=\"date\"]") %>%
          rvest::html_text() %>%
          strptime(format = "%B %d, %Y | %I:%M %p")
      }

      if (length(datetime) > 1) {
        datetime <- datetime[1]
      }

      # headline
      headline <- html %>%
        rvest::html_elements("[property=\"og:title\"]") %>%
        rvest::html_attr("content")

      # author
      author <- html %>%
        rvest::html_elements("[data-qa=\"author-name\"],[class*=\"author-name \"]")  %>%
        rvest::html_text2() %>%
        toString()

      # text
      text_temp <- html %>%
        rvest::html_elements("[class=\"article-body\"]")

      if (length(text_temp) > 0) {
        text <- text_temp %>%
          rvest::html_elements("p") %>%
          rvest::html_text2() %>%
          paste(collapse = "\n")
      } else {
        text <- html %>%
          rvest::html_elements("p") %>%
          rvest::html_text2() %>%
          paste(collapse = "\n")
      }

      s_n_list(
        datetime,
        author,
        headline,
        text
      )
    }
  }) %>%
    cbind(x) %>%
    normalise_df() %>%
    return()
}
