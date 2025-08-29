# Use the official R base image (like openanalytics/r-ver) to avoid shiny-server
FROM openanalytics/r-ver:4.3.3

# Set Shiny app port and host (to allow connections from outside)
RUN echo "\noptions(shiny.port=3838, shiny.host='0.0.0.0')" >> /usr/local/lib/R/etc/Rprofile.site

# Install system dependencies (add any your app needs)
RUN apt-get update && apt-get install --no-install-recommends -y \
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

# Set working directory and copy app files
WORKDIR /app
COPY . /app

# Install shiny and any other R packages your app requires
RUN R -e "install.packages(c('shiny', 'renv', 'markdown'), repos='https://cloud.r-project.org')"

# If you use renv for package management, restore packages
RUN R -e "renv::restore(confirm = FALSE)" || true

# Expose port 3838 for shiny app
EXPOSE 3838

# Run the app with shiny::runApp
CMD ["R", "-e", "shiny::runApp('/app', host='0.0.0.0', port=3838)"]

