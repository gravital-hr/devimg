#!/bin/sh

set -e

if [ "$DEV_MODE" = "true" ]; then

	# disable cache for nginx
	cat <<EOF >/opt/docker/etc/nginx/vhost.common.d/11-nocache.conf
add_header Last-Modified \$date_gmt;
add_header Cache-Control 'no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0';
if_modified_since off;
expires off;
etag off;
EOF

	# disable access log for nginx
	cat <<EOF >/opt/docker/etc/nginx/vhost.common.d/10-log.conf
access_log   /dev/null detailed;
error_log    /docker.stderr warn;
EOF

fi
