#!/bin/bash


# Web status monitor (nginx / php)

web_stat_log=web.status
url="http://www.oray.com/"
server_status_code=`curl -o /dev/null -s -m 10 --connect-timeout 10 -w %{http_code} "$url"`

echo $server_status_code

if [ "$server_status_code" = "200" ]; then
        echo "`date '+%Y-%m-%d %H:%M:%S'` visit $website status code 200 OK" >>$web_stat_log
   else
        echo "`date '+%Y-%m-%d %H:%M:%S'` visit $website error!!!Restarting..." >>$web_stat_log
        /etc/init.d/php-fpm restart
fi

