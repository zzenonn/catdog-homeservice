FROM nginx:alpine
ARG AWS_DEFAULT_REGION
ARG AWS_CONTAINER_CREDENTIALS_RELATIVE_URI
RUN mkdir -p /aws && \
	apk -Uuv add groff less python py-pip && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*
RUN adduser -D -u 1000 -g 'www' www
RUN mkdir /www && \
    chown -R www:www /www
COPY nginx.conf /etc/nginx/nginx.conf
COPY html /www/
EXPOSE 80/tcp
CMD nginx -g "daemon off;"
