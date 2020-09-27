FROM alpine:3.12

WORKDIR /home/app

RUN apk add --no-cache s6 nginx openssl curl && \
	rm -r /etc/nginx/conf.d /etc/nginx/modules && \
	rm /etc/nginx/fastcgi.conf /etc/nginx/scgi_params /etc/nginx/uwsgi_params
ADD s6 /s6
COPY nginx/nginx.template.conf nginx.template.conf
COPY nginx/ssl.template.conf ssl.template.conf
COPY nginx/create_pem.sh create_pem.sh
COPY nginx/getpfxfile getpfxfile
COPY htdocs /var/www/localhost/htdocs/

CMD ["s6-svscan", "/s6"]

