FROM debian:stretch

# argument section
ARG VARNISH_MAJOR_VERSION=60
ARG BACKEND_PORT=80
ARG BACKEND_HOST=http-backend

# installation
ADD scripts/* /
RUN chmod +x *.sh

RUN sh ./install_varnish.sh ${VARNISH_MAJOR_VERSION} && rm install_varnish.sh

# configuration
ADD config/secret /etc/varnish/secret
ADD config/backend.vcl /etc/varnish/backend.vcl
RUN sed -i -e "s/{BACKEND_HOST}/${BACKEND_HOST}/" -e "s/{BACKEND_PORT}/${BACKEND_PORT}/" /etc/varnish/backend.vcl
ADD config/default.vcl /etc/varnish/default.vcl
RUN echo "Build done with configuration: " && echo "/etc/varnish/default.vcl" && cat /etc/varnish/default.vcl && echo "/etc/varnish/backend.vcl" && cat /etc/varnish/backend.vcl

# service
VOLUME ["/var/lib/varnish", "/etc/varnish", "/etc/varnish/user_configs"]
EXPOSE 80
ENV VARNISH_START /usr/sbin/varnishd -j unix,user=varnish -F -f /etc/varnish/default.vcl -a 0.0.0.0:80 -s malloc,1g -T 127.0.0.1:6082 -S /etc/varnish/secret

CMD ["/start.sh"]
