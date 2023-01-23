
#remotes::install_github("https://github.com/seankellyhp/paperboy_emmy", force = TRUE)
# Hacky method to deliver Islamische Zeitung function

# Functions

s_n_list <- function(...) {
# Join all content safely into list 
    
  len_check <- function(x) {
    if (length(x) == 0L) {
      return(NA)
    } else if (length(x) > 1L) {
      return(list(x))
    } else {
      return(x)
    }
  }
  
  nms <- sapply(as.list(substitute(list(...))), deparse)[-1]
  
  out <- lapply(list(...), len_check)
  
  stats::setNames(out, nms)
}

parseURL <- function(urlMeta) {
# Download and scrape content from a url 
  
  require(rvest)
  html <- rvest::read_html(urlMeta$content_raw)
  
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
  
  # reformat
  parsedTxt <- data.frame(s_n_list(
    datetime,
    author,
    headline,
    text
  ))
  
  # join to urlMeta
  cbind(urlMeta, parsedTxt)
  
}

scrapeContent <- function(url) {
# If error when scraping content return exit function and warn 
  
  require(paperboy)
  
  urlMeta <- pb_collect(url)
  
  if (urlMeta$status == 404 && length(urlMeta) > 0) {
    
    return (urlMeta)
    
  } else if (length(urlMeta) == 0) {
    
    print(paste('Encountered a blank url. Please only use full URL paths to news articles.', url))
    
    return(NULL)
    
  } else {
    
    parseURL(urlMeta)
    
  }
}

safeScrape <- function(url) {
# When scraping urls, retry on fail
  
  out <- tryCatch(
    {
      
      scrapeContent(url)
      
    }, 
    error=function(cond) {
      
      count = 0
      maxTries = 3
      urlContent <- NULL
      
      while( is.null(urlContent) && count <= maxTries ) {
        count = count + 1
        Sys.sleep(10**count)
        
        print(paste('Try number:', count))
        
        try(
          urlContent <- scrapeContent(url)
        )
      }
      
      if (is.null(urlContent)) {
        
        message(paste("Could not complete scrape:", url))
        message("Here's the original error message:")
        message(cond)
        # Choose a return value in case of error
        #print(NA)
        return(NA)
        
      } else {
        
        #print(words)
        return(urlContent)
        
      }
    }
  )
}

pb_islamische_all <- function(listURL) {
# Join all scraped content into a data frame 
   
  scrapedURLs <- lapply(listURL, safeScrape)
  urlDF <- dplyr::bind_rows(scrapedURLs)
  dplyr::select(urlDF, -content_raw, -status, -expanded_url)
  
}






