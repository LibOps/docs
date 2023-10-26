FROM python:3.9-alpine

RUN mkdir -p /docs
WORKDIR /docs
COPY . .
RUN apk add --no-cache cairo \
  && pip install -r requirements.txt \
  && mkdocs build

FROM nginx:1.25

COPY --from=0 /docs/site /usr/share/nginx/html
