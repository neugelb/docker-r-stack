FROM rocker/verse:3.6.1
MAINTAINER Stefan Baur <stefan.baur@neugelb.com>


# Install java and rJava
RUN apt-get -y update && apt-get install -y \
    default-jdk \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libapparmor1 \
    libedit2 \
    libssl-dev \
    lsb-release \
    libjpeg-dev \
    && R CMD javareconf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# Install ODBC stuff
RUN apt-get -y update && apt-get install -y --install-suggests \
    unixodbc unixodbc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# Install further R packages
RUN install2.r --error --deps TRUE \
    RJDBC \
    odbc \
    devtools \
    formatR \
    remotes \
    selectr \
    caTools \
    tidyverse httr jsonlite googlesheets purrr snakecase lubridate scales readxl knitr zoo tinytex extrafont showtext kableExtra flextable xtable rmarkdown data.table \ 
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN R -e "install.packages('rJava')"

