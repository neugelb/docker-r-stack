FROM rocker/tidyverse
MAINTAINER Stefan Baur <stefan.baur@neugelb.com>

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libjpeg-dev
RUN install2.r --error \
    --deps TRUE \
    tidyverse httr jsonlite googlesheets purrr	snakecase
