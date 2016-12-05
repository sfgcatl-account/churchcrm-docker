#!/bin/bash
set -eu

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

if [[ "$1" == apache2* ]] || [ "$1" == php-fpm ]; then
	file_env 'CHURCHCRM_DB_HOST' 'mysql'
	# if we're linked to MySQL and thus have credentials already, let's use them
	file_env 'CHURCHCRM_DB_USER' "${MYSQL_ENV_MYSQL_USER:-root}"
	if [ "$CHURCHCRM_DB_USER" = 'root' ]; then
		file_env 'CHURCHCRM_DB_PASSWORD' "${MYSQL_ENV_MYSQL_ROOT_PASSWORD:-}"
	else
		file_env 'CHURCHCRM_DB_PASSWORD' "${MYSQL_ENV_MYSQL_PASSWORD:-}"
	fi
	file_env 'CHURCHCRM_DB_NAME' "${MYSQL_ENV_MYSQL_DATABASE:-CHURCHCRM}"
	if [ -z "$CHURCHCRM_DB_PASSWORD" ]; then
		echo >&2 'error: missing required CHURCHCRM_DB_PASSWORD environment variable'
		echo >&2 '  Did you forget to -e CHURCHCRM_DB_PASSWORD=... ?'
		echo >&2
		echo >&2 '  (Also of interest might be CHURCHCRM_DB_USER and CHURCHCRM_DB_NAME.)'
		exit 1
	fi
fi

exec "$@"
