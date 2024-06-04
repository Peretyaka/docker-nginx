ARG NGINX_VERSION="1.27.0"

FROM nginx:${NGINX_VERSION}
COPY --chmod=0555 docker-entrypoint.d/ /docker-entrypoint.d/
COPY nginx.conf /etc/nginx/conf.d/default.conf
