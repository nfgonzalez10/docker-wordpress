#!/bin/sh
DB_CID=$(docker create -e MYSQL_ROOT_PASSWORD=ch2demo mysql:5.7)
docker start $DB_CIDMAILER_CID=$(docker create dockerinaction/ch2_mailer)
docker start $MAILER_CIDWP_CID=$(docker create --link $DB_CID:mysql -p 80 \  --read-only -v /run/apache2/ --tmpfs /tmp \  wordpress:5.0.0-php7.2-apache)
docker start $WP_CIDAGENT_CID=$(docker create --link $WP_CID:insideweb \  --link $MAILER_CID:insidemailer \  dockerinaction/ch2_agent)
docker start $AGENT_CID
