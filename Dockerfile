FROM r-base
MAINTAINER Stefan Baur <stefan.baur@neugelb.com>

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libmariadb-client-lgpl-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libapparmor1 \
    libcurl4-openssl-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    libjpeg-dev
RUN install2.r --error \
    --deps TRUE \
    devtools \
    formatR \
    remotes \
    selectr \
    caTools \
    tidyverse httr jsonlite googlesheets purrr snakecase

ENTRYPOINT [ "/bin/bash", "-c" ]
