FROM rocker/r-ver:4.4.1

ENV DEBIAN_FRONTEND=noninteractive

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

WORKDIR /app
COPY . /app

RUN R -e "install.packages(c('renv', 'markdown'), repos='https://cloud.r-project.org')"
RUN R -e "renv::restore(confirm = FALSE)"

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app', host='0.0.0.0', port=3838)"]