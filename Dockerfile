FROM rocker/r-ver:4.4.1

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "\noptions(shiny.port=3838, shiny.host='0.0.0.0')" >> /usr/local/lib/R/etc/Rprofile.site


RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libxt-dev \
    libv8-dev \
    libgit2-dev \
    git \
    pandoc \
    && rm -rf /var/lib/apt/lists/*



COPY causalapp /app
COPY renv.lock /app/renv.lock
COPY text /app/text

WORKDIR /app

RUN R -e "install.packages(c('renv', 'markdown'), repos='https://cloud.r-project.org')"
RUN R -e "renv::restore(confirm = FALSE)"


EXPOSE 3838

RUN groupadd -g 1000 shiny && useradd -c 'shiny' -u 1000 -g 1000 -m -d /home/shiny -s /sbin/nologin shiny
USER shiny



CMD ["R", "-q", "-e", "shiny::runApp('/app')"]

