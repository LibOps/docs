FROM python:3.13-alpine@sha256:657dbdb20479a6523b46c06114c8fec7db448232f956a429d3cc0606d30c1b59

RUN mkdir -p /docs

WORKDIR /docs

COPY requirements.txt .
RUN apk add --no-cache cairo \
  && pip install -r requirements.txt 

COPY . .
RUN mkdocs build

# serve the docs via nginx
FROM nginx:1.27@sha256:42e917aaa1b5bb40dd0f6f7f4f857490ac7747d7ef73b391c774a41a8b994f15
COPY --from=0 /docs/site /usr/share/nginx/html
RUN echo 'real_ip_header X-Forwarded-For;' > /etc/nginx/conf.d/real-ip.conf \
  && echo 'set_real_ip_from 169.254.1.1/32;' >> /etc/nginx/conf.d/real-ip.conf
