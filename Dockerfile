FROM rocker/verse:3.6.1
MAINTAINER Stefan Baur <stefan.baur@neugelb.com>


# Install java and rJava and some fonts
RUN echo "deb http://httpredir.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://httpredir.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get -y update && apt-get install -y \
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
    cargo \
    libglu1-mesa-dev freeglut3-dev mesa-common-dev gpg sudo curl ttf-mscorefonts-installer \
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

# make /opt/TinyTeX writable for all users to allow users to install new packages on the fly
RUN chmod a+w -R /opt/TinyTeX
RUN chmod a+w /usr/local/bin

