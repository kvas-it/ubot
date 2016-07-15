#!/bin/sh

SRC=/vagrant/master
BB_HOME=/var/buildbot
BB_ENV=$BB_HOME/venv
BB_BIN=$BB_ENV/bin
BB_ROOT=$BB_HOME/master
INIT_SCRIPT=/etc/init.d/buildbot

set -e

if dpkg -l | grep -q python-virtualenv; then
    echo "Packages already installed"
else
    apt-get -y update
    apt-get -y install git mercurial python-virtualenv python-dev
fi

if [ ! -d $BB_HOME ]; then
    useradd --create-home --home-dir $BB_HOME --uid 555 \
            --shell /bin/false --user-group -- buildbot
fi

if [ ! -d $BB_ENV ]; then
    sudo -u buildbot virtualenv $BB_ENV
    sudo -u buildbot $BB_BIN/pip install -r $SRC/requirements-master.txt
fi

if [ ! -d $BB_ROOT ]; then
    sudo -u buildbot $BB_BIN/buildbot create-master $BB_ROOT
    sudo -u buildbot cp $SRC/master.cfg $SRC/workers.yaml $SRC/jobs.yaml \
                        $BB_ROOT
fi

if [ ! -f $INIT_SCRIPT ]; then
    cp $SRC/buildbot.init.sh $INIT_SCRIPT
    chmod +x $INIT_SCRIPT
    update-rc.d buildbot defaults
    $INIT_SCRIPT start
fi


HG_HOME=/var/hg
HG_REPOS=$HG_HOME/repos

if [ ! -d $HG_HOME ]; then
    useradd --create-home --home-dir $HG_HOME --uid 666 \
            --shell /usr/bin/hg-ssh --user-group -- hg
    sudo -u hg mkdir $HG_REPOS
    sudo -u hg mkdir $HG_REPOS/poke-mongo
    sudo -u hg hg init --cwd $HG_REPOS/poke-mongo
fi
