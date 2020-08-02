FROM python:3 AS builder

RUN useradd scrapy && mkdir /app && chown scrapy /app
USER scrapy
COPY requirements.txt Makefile /app
WORKDIR /app
RUN make venv
COPY immospider scrapy.cfg jinja2 /app
COPY immospider /app/immospider
COPY jinja2 /app/jinja2



FROM python:3-slim
RUN useradd scrapy && mkdir /app && chown scrapy /app
USER scrapy
COPY --from=builder /app /app
WORKDIR /app
CMD venv/bin/scrapy crawl immoscout -o /output/apartments.csv -a url=$URL  -L INFO
