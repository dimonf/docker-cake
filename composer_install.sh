#!/bin/sh
#source: https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
#adapted for docker container that lacks wget

EXPECTED_SIGNATURE=$(php -r 'print_r(file_get_contents("https://composer.github.io/installer.sig"));')
#EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature:'
		>&2 echo "EXPECtED_SIGNATURE:$EXPECTED_SIGNATURE"
		>&2 echo "ACTUAL_SIGNATURE:$ACTUAL_SIGNATURE"
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
exit $RESULT
