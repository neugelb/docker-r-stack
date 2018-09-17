FROM rocker/tidyverse
MAINTAINER Stefan Baur <stefan.baur@neugelb.com>

RUN install2.r --error \
    --deps TRUE \
    tidyverse httr jsonlite googlesheets purrr	snakecase
