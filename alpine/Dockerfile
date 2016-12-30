FROM alpine:3.5
MAINTAINER OKUMURA Takahiro <hfm.garden@gmail.com>

ENV NGINX_CONFIG_OPT_ENV \
      --prefix=/etc/nginx \
      --sbin-path=/usr/sbin/nginx \
      --modules-path=/usr/lib/nginx/modules \
      --conf-path=/etc/nginx/nginx.conf \
      --error-log-path=/var/log/nginx/error.log \
      --http-log-path=/var/log/nginx/access.log \
      --pid-path=/var/run/nginx.pid \
      --lock-path=/var/run/nginx.lock \
      --http-client-body-temp-path=/var/cache/nginx/client_temp \
      --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
      --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
      --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
      --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
      --user=nginx \
      --group=nginx \
      --with-file-aio \
      --with-threads \
      --with-http_addition_module \
      --with-http_auth_request_module \
      --with-http_dav_module \
      --with-http_flv_module \
      --with-http_gunzip_module \
      --with-http_gzip_static_module \
      --with-http_mp4_module \
      --with-http_random_index_module \
      --with-http_realip_module \
      --with-http_secure_link_module \
      --with-http_slice_module \
      --with-http_ssl_module \
      --with-http_stub_status_module \
      --with-http_sub_module \
      --with-http_v2_module \
      --with-mail \
      --with-mail_ssl_module \
      --with-stream \
      --with-stream_realip_module \
      --with-stream_ssl_module \
      --with-stream_ssl_preread_module

ENV NGX_MRUBY_VERSION v1.18.7

RUN addgroup -S nginx \
      && adduser -D -S -h /etc/nginx -s /sbin/nologin -g nginx -G nginx nginx \
      && apk add --no-cache --virtual .build-deps gcc make libc-dev linux-headers pcre-dev zlib-dev openssl-dev git ruby-rake bison
      && mkdir -p /usr/src
      && git clone --depth=1 --branch=$NGX_MRUBY_VERSION https://github.com/matsumoto-r/ngx_mruby.git /usr/src/ngx_mruby \
      && cd /usr/src/ngx_mruby \
      && sh build.sh \
      && make install \
      && rm -rf /usr/local/src/ngx_mruby
      && apk del .build-deps

EXPOSE 80 443

ONBUILD ADD docker/hook.d /etc/nginx/hook.d
ONBUILD ADD docker/conf.d /etc/nginx/conf.d
ONBUILD ADD docker/nginx.conf /etc/nginx/nginx.conf

CMD ["/usr/sbin/nginx"]
