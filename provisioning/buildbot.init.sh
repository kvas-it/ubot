#!/bin/bash

### BEGIN INIT INFO
# Provides:          buildmaster
# Required-Start:
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Buildbot master init script
# Description:       This file allows running buildbot master instances at
#                    startup
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin

BB_HOME=/var/buildbot/
BB_SCRIPT=$BB_HOME/venv/bin/buildbot
BB_ROOT=$BB_HOME/master

bb() {
    sudo -u buildbot $BB_SCRIPT $1 $BB_ROOT
}

case "$1" in
    start|stop|restart|status)
        bb $1
        exit $?
        ;;
    reload)
        bb reconfig
        exit $?
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|reload|status}"
        exit 1
esac
