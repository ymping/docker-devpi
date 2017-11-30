# docker-devpi
Python PyPI caching service implemented with docker and devpi

This repository contains a Dockerfile for [Devpi](http://doc.devpi.net/latest/).
You can use this container to speed up your python package installation by using `pip install xxx` or `easy_install  xxx`. Enjoy!

# Getting Started

## Installation
docker build -t devpi https://github.com/ymping/docker-devpi.git

## Quickstart

```bash
docker run -d --name devpi \
	--publish 3141:3141 \
	--volume /srv/docker/devpi:/data \
	--env=DEVPI_PASSWORD=ChangeToYourPassword
	--restart always \
	devpi
```