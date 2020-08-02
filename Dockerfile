FROM python:3 AS builder

RUN useradd scrapy && mkdir /app && chown scrapy /app
USER scrapy
COPY . /app
WORKDIR /app

RUN make venv

FROM python:3-slim
RUN useradd scrapy && mkdir /app && chown scrapy /app
USER scrapy
COPY --from=builder /app /app
WORKDIR /app
CMD venv/bin/scrapy crawl immoscout -o /output/apartments.csv -a url=$URL  -L INFO
