FROM public.ecr.aws/nginx/nginx:stable-alpine
ARG AWS_DEFAULT_REGION
ARG AWS_CONTAINER_CREDENTIALS_RELATIVE_URI
RUN mkdir -p /aws && \
	apk -Uuv add groff less python3 py-pip && \
	pip3 install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*
RUN adduser -D -u 1000 -g 'www' www
RUN mkdir /www && \
    chown -R www:www /www
COPY nginx.conf /etc/nginx/nginx.conf
COPY html /www/
EXPOSE 80/tcp
CMD ["nginx", "-g", "daemon off;"]
