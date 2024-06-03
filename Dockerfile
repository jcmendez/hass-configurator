FROM python:3.11-alpine
LABEL maintainer="Juan C. Mendez<jcmendez@alum.mit.edu>"

WORKDIR /app

ARG HC_BUILD_VERSION=0.5.4

RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash git openssh && \
    pip install --no-cache-dir gitpython pyotp && \
    pip install --no-cache-dir git+https://github.com/jcmendez/hass-configurator.git

COPY ./run.sh /app/
RUN chmod a+x /app/run.sh

EXPOSE 3218
VOLUME /config
ENTRYPOINT ["su", "-p", "nobody", "-s", "/bin/sh", "-c", "/app/run.sh"]