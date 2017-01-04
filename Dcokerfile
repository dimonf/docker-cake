FROM php:7.1-cli


RUN requirements="libmcrypt-dev g++ libicu-dev git unzip" \
    && apt-get update && apt-get install -y $requirements && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install intl \
    && requirementsToRemove="g++" \
    && apt-get purge --auto-remove -y $requirementsToRemove

COPY ./composer_install.sh /usr/src/cakephp/
WORKDIR /usr/src/cakephp
RUN /bin/bash ./composer_install.sh

RUN php composer.phar create-project --prefer-dist cakephp/app \
    --keep-vcs --no-interaction my_cake_app 

CMD ["/bin/bash"]
