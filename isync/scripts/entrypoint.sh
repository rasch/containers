#!/bin/sh

# shellcheck source=../config/.env
. "$HOME"/.env

exec "$@"
