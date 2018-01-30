#!/bin/sh

# set -e
# set -x

function initialise_devpi {
    echo "[RUN]: Initialise devpi-server"
    devpi-server --init
    devpi-server --restrict-modify root --start --host 127.0.0.1 --port 3141
    devpi-server --status
    devpi use http://localhost:3141
    devpi login root --password=''
    devpi user -m root password="${DEVPI_PASSWORD}"
    devpi index -y -c public pypi_whitelist='*'
    devpi index root/pypi mirror_url="${MIRROR_URL}"
    devpi-server --stop
    devpi-server --status
}

echo "DEVPI_SERVERDIR is ${DEVPI_SERVERDIR}"
echo "DEVPI_CLIENTDIR is ${DEVPI_CLIENTDIR}"

export DEVPI_SERVERDIR=${DEVPI_SERVERDIR}
export DEVPI_CLIENTDIR=${DEVPI_CLIENTDIR}

if [ "$1" = "devpi" ]; then
    if [ ! -f $DEVPI_SERVERDIR/.serverversion ]; then
        initialise_devpi
    fi

    echo "[RUN]: Launching devpi-server"
    exec devpi-server --restrict-modify root --host 0.0.0.0 --port 3141
fi

echo "[RUN]: Builtin command not provided [devpi]"
echo "[RUN]: $@"

exec "$@"
