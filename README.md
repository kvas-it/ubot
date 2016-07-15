# UBot

Buildbot-in-a-box prototype for Uplink project.

## Set up

UBot requires [Vagrant](https://www.vagrantup.com/). With Vagrant
[installed](https://www.vagrantup.com/docs/installation/) change
to the directory that contains this file and execute:

    $ vagrant up

This should install the vagrant container with buildbot master
and docker, create docker images for one worker and start it.

After the container starts point your browser to
[http://10.8.10.8:8080/](http://10.8.10.8:8080/).
