# Use rocker/shiny as base because it includes R and Shiny
FROM rocker/shiny:4.4.1

# Avoid interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install system libraries needed for typical R packages
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


# Set working directory inside the container
WORKDIR /app

# Copy your Shiny app files into the container
#COPY . /app
COPY . /srv/shiny-server/

# Install renv and restore package environment (if using renv)
RUN R -e "install.packages(c('renv', 'markdown'), repos = 'https://cloud.r-project.org'); renv::restore(confirm = FALSE)"

# Switch to shiny user (already exists in rocker/shiny image)
USER shiny

# Expose default Shiny port
EXPOSE 3838

# Run the app using shiny::runApp, binding to all interfaces so ShinyProxy can access it
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
