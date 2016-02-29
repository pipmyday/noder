# Base image for node.js and R.

Docker base image for running applications that require node and R.

[![](https://badge.imagelayers.io/pipmyday/noder:latest.svg)](https://imagelayers.io/?images=pipmyday/noder:latest 'Get your own badge on imagelayers.io')

This base image runs on Ubuntu/wily. For dependencies, it uses [buildpack-deps:wily](https://hub.docker.com/_/buildpack-deps/), then pulls R from http://cran.rstudio.com/bin/linux/ubuntu and finally installs [node:5-slim](https://hub.docker.com/_/node/).

## Suported tags

Tags correlate with the version of R.

* `latest`, `3.2.3` [(3.2.3/Dockerfile)](https://github.com/pipmyday/noder/blob/master/Dockerfile)

----

©2016 by Pipmyday
