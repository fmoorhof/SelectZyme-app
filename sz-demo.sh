#!/usr/bin/bash
#
# sz-demo helper script to start/stop the sz-demo
#
p=`dirname $0`
DIR=`realpath $p`
cd $DIR

function installFunc {
    cat sz-demo.service | \
    sed s:LOCAL_SZ_INSTALLATION_SOURCE:$DIR: \
    > /etc/systemd/system/sz-demo.service
    systemctl daemon-reload
    systemctl enable sz-demo.service
    systemctl start sz-demo.service
}

case $1 in
    start)
        docker-compose up -d
        ;;
    stop)
        docker-compose down
        ;;
    install)
        installFunc
        ;;
    update)
        echo "Update is currently not supported"
        ;;
    *)
        echo "Usage: sz-demo.sh [start|stop|install|update]"
        ;;
esac