FROM ubuntu:16.04
MAINTAINER OKUMURA Takahiro <hfm.garden@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update && apt-get --no-install-recommends -qq install git wget g++ make rake bison libxml2-dev libssl-dev libpcre3 libpcre3-dev >/dev/null

ENV NGINX_CONFIG_OPT_ENV --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module

RUN git clone --depth=1 https://github.com/matsumoto-r/ngx_mruby.git /usr/local/src/ngx_mruby && cd /usr/local/src/ngx_mruby && sh build.sh && make install && rm -rf /usr/local/src/ngx_mruby

EXPOSE 80 443

ONBUILD ADD docker/hook.d /etc/nginx/hook.d
ONBUILD ADD docker/conf.d /etc/nginx/conf.d
ONBUILD ADD docker/nginx.conf /etc/nginx/nginx.conf

CMD ["/usr/sbin/nginx"]
