FROM rocker/r-ver:4.1.0

RUN apt-get update && apt-get install -y \
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2-dev \
  && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('remotes', repos='http://cran.rstudio.com/')"
RUN R -e "remotes::install_github('ebeneditos/telegram.bot')"

WORKDIR /app
COPY . .
CMD ["Rscript", "bot.R"]
