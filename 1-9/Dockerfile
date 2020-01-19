FROM alpine:3.11.2
LABEL maintainer="student302"
RUN apk update && apk add nginx
RUN ln -s /dev/stdout /var/log/nginx/access.log && \
    ln -s /dev/stderr /var/log/nginx/error.log
RUN mkdir -p /run/nginx
COPY nginxconfig.conf /etc/nginx/conf.d/default.conf
EXPOSE 80	
CMD ["nginx", "-g", "daemon off;"]


