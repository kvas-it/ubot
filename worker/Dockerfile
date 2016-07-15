FROM debian:jessie
RUN apt-get -y update
RUN apt-get -y install git mercurial python-virtualenv python-dev gcc
RUN /usr/sbin/useradd \
    --create-home \
    --home-dir /var/buildbot \
    --uid 555 \
    --user-group \
    -- buildbot
USER buildbot
WORKDIR /var/buildbot
RUN virtualenv venv
RUN venv/bin/pip install buildbot-worker==0.9.0rc1
RUN venv/bin/buildbot-worker create-worker worker 10.8.10.8 worker1 pass1
ENV LC_ALL C.UTF-8
ENTRYPOINT ["venv/bin/buildbot-worker"]
CMD ["start", "--nodaemon", "worker"]
