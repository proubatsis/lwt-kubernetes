FROM busybox

WORKDIR /var/lwt
RUN wget https://downloads.sourceforge.net/project/lwt/lwt_v_1_6_2.zip -O lwt.zip
RUN unzip lwt.zip && rm lwt.zip
RUN tar -czf lwt.tar.gz .

FROM php:5-apache

WORKDIR /var/www/html
RUN apt-get update && apt-get install -y libpng-dev
RUN docker-php-ext-install mbstring pdo pdo_mysql mysqli gd

COPY --from=0 /var/lwt/lwt.tar.gz ./
RUN tar -zxf lwt.tar.gz && rm lwt.tar.gz

COPY connect.inc.php /etc/config/connect.inc.php
RUN ln -s /etc/config/connect.inc.php /var/www/html/connect.inc.php
RUN chown -R www-data:www-data ./ && chmod -R 755 ./
