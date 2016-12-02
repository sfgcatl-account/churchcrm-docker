FROM nimmis/alpine-apache
MAINTAINER Jason Skipper <jason@skipperinnovations.com>

RUN apk update && apk upgrade && \

    # Make info file about this build
    printf "Build of skipper/alpine-apache, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "@edge https://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update && apk upgrade && \

    # Make info file about this build
    printf "Build of skipper/alpine-apache-php7, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \
    apk add libressl@edge && \
    apk add curl \
            wget \
            openssl \
            bash \
            nano \
            openrc \
            jq \
            php7@community \
            php7-apache2@community \
            php7-openssl@community \
            php7-mbstring@community \
            php7-session@community \
            php7-pdo@community \
            php7-xml@community \
            php7-exif@community \
            php7-pdo_mysql@community \
            php7-apcu@testing \
            php7-intl@community \
            php7-mcrypt@community \
            php7-json@community \
            php7-gd@community \
            php7-curl@community \
            php7-fpm@community \
            php7-mysqlnd@community \
            php7-pgsql@community \
            php7-sqlite3@community \
            php7-phar@community \
            php7-gettext@community && \

    ln -s /usr/bin/php7 /usr/bin/php && \
    cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \
    rm -rf /var/cache/apk/* && \
    mkdir /web/churchcrm

COPY include/httpd.conf /etc/apache2
COPY include/60-churchcrm /etc/run_always
# Auto-logging for now
COPY include/Config.php.example /web/churchcrm/Config.php

RUN chmod 755 /etc/run_always/60-churchcrm

# Enable Terminal
ENV TERM xterm
