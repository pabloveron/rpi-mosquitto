#!/bin/sh

USER_ID=${LOCAL_USER_ID:-9001}

useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
echo "Starting with UID : $USER_ID"

set -e

exec "$@"
