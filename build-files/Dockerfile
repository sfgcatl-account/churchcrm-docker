FROM jaskipper/alpine-apache-php7
MAINTAINER ChurchCRM

RUN apk update && apk upgrade && \

    # Make info file about this build
    printf "Build of skipper/alpine-apache, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD

RUN apk add --no-cache \
            jq \
            php7-session@community \
            php7-pdo@community \
            php7-xml@community \
            php7-exif@community \
            php7-pdo_mysql@community \
            php7-gettext@community

RUN mkdir /web/churchcrm

COPY httpd.conf /etc/apache2
COPY 60-churchcrm /etc/run_always

RUN chmod +x /etc/run_always/60-churchcrm

# Enable Terminal
ENV TERM xterm
