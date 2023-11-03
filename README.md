# Docker Alpine AWS CLI

Uses as a base image [Alpine GLibC](https://github.com/kohirens/docker-alpine-glibc)

NOTICE: This image has vanilla GLibC and some older deprecated functions may not
be available. So when you run any app that uses the glibc, then you may
get info messages output. You may ignore these if your app continues to pass
all of its test.

Testing is critical before taking your app to production.

## Status

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/kohirens/docker-alpine-awscli/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/kohirens/docker-alpine-awscli/tree/main)

## Features

AWS CLI v2 on Alpine 3.18

## Usage

* Running AWS CLI command from build systems.
* Running AWS CLI command locally if you have a container engine already
  installed.


See Docker Hub image tags at [kohirens/alpine-awscli]

---

[kohirens/alpine-awscli]: https://hub.docker.com/repository/docker/kohirens/alpine-awscli
