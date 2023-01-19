
# paperboy <img src="man/figures/logo.svg" align="right" height="139" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/JBGruber/paperboy/workflows/R-CMD-check/badge.svg)](https://github.com/JBGruber/paperboy/actions)
[![Codecov test
coverage](https://codecov.io/gh/JBGruber/paperboy/branch/main/graph/badge.svg)](https://codecov.io/gh/JBGruber/paperboy?branch=main)
<!-- badges: end -->

[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/JohannesBGruber.svg?style=social&label=Follow%20%40JohannesBGruber)](https://twitter.com/JohannesBGruber)

COPY OF PAPERBOY FOR TEST PURPOSES

## Installation

`paperboy` is not on [CRAN](https://CRAN.R-project.org) yet. Install via
`remotes` (first install `remotes` via `install.packages("remotes")`:

``` r
remotes::install_github("https://github.com/seankellyhp/paperboy_emmy")
```

## For developers

If there is no scraper for a news site and you want to contribute one to
this project, you can become a co-author of this package by adding it
via a pull request. First check [available
scrapers](#available-scrapers) and open
[issues](https://github.com/JBGruber/paperboy/issues) and [pull
requests](https://github.com/JBGruber/paperboy/pulls). Open a new issue
or comment on an existing one to communicate that you are working on a
scraper (so that work isn’t done twice). Then start by pulling a few
articles with `pb_collect` and start to parse the html code in the
`content_raw` column (preferably with `rvest`).

Every webscraper should retrieve a `tibble` with the following format:

| url                                 | expanded_url | domain     | status           | datetime             | headline     | author     | text          | misc                                                                      |
|:------------------------------------|:-------------|:-----------|:-----------------|:---------------------|:-------------|:-----------|:--------------|:--------------------------------------------------------------------------|
| character                           | character    | character  | integer          | as.POSIXct           | character    | character  | character     | list                                                                      |
| the original url fed to the scraper | the full url | the domain | http status code | publication datetime | the headline | the author | the full text | all other information that can be consistently found on a specific outlet |

Since some outlets will give you additional information, the `misc`
column was included so these can be retained.

## Available Scrapers

| domain                            | status                                                        | author                                    | issues                                               |
|:----------------------------------|:--------------------------------------------------------------|:------------------------------------------|:-----------------------------------------------------|
| buzzfeed.com                      | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| cbslnk.cbsileads.com              | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| dailymail.co.uk                   | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| decider.com                       | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| edition.cnn.com                   | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| eu.usatoday.com                   | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| faz.net                           | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| forbes.com                        | ![](https://img.shields.io/badge/status-silver-%23C0C0C0.svg) | [@JBGruber](https://github.com/JBGruber/) | [#2](https://github.com/JBGruber/paperboy/issues/2) |
| fortune.com                       | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| ftw.usatoday.com                  | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| huffingtonpost.co.uk              | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| lnk.techrepublic.com              | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| marketwatch.com                   | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| newsweek.com                      | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| nypost.com                        | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| nytimes.com                       | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| pagesix.com                       | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| theguardian.com                   | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| time.com                          | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| us.cnn.com                        | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| usatoday.com                      | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| washingtonpost.com                | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| wsj.com                           | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| www.boston.com                    | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| www.bostonglobe.com               | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| www.cbsnews.com                   | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| www.cnet.com                      | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| www.foxbusiness.com               | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| www.foxnews.com                   | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| www.latimes.com                   | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| www.msnbc.com                     | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| www.sfgate.com                    | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| www.telegraph.co.uk               | ![](https://img.shields.io/badge/status-gold-%23ffd700.svg)   | [@JBGruber](https://github.com/JBGruber/) |                                                      |
| www.thelily.com                   | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| www.thismorningwithgordondeal.com | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |
| www.tribpub.com                   | ![](https://img.shields.io/badge/status-requested-lightgrey)  |                                           | [#1](https://github.com/JBGruber/paperboy/issues/1) |

- ![](https://img.shields.io/badge/status-gold-%23ffd700.svg): Runs
  without known issues
- ![](https://img.shields.io/badge/status-silver-%23C0C0C0.svg): Runs
  with some issues
- ![](https://img.shields.io/badge/status-broken-%23D8634C)![](https://img.shields.io/badge/status-requested-lightgrey):
  Currently not working, fix has been requested
