###
# Pipmyday/noder
#
# Base image for running applications that require node and R.
#
# version: 3.2.3
#
# repository: https://github.com/pipmyday/noder
# docker hub: https://hub.docker.com/r/pipmyday/noder/
# acknowledgements:
#   - https://cran.r-project.org/bin/linux/ubuntu/README
#   - https://hub.docker.com/_/node/
# ©2016 by Pipmyday
#
###

FROM buildpack-deps:wily

MAINTAINER "Jakob Hohlfeld" jhohlfeld@polyban.io

ENV R_BASE_VERSION 3.2.3

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu wily/" >> /etc/apt/sources.list \
  && echo "deb http://cran.rstudio.com/bin/linux/ubuntu wily-backports main restricted universe"
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN apt-get update
RUN apt-get install -y --force-yes r-base

# gpg keys listed at https://github.com/nodejs/node
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 5.7.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --verify SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt.asc | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc

CMD [ "node" ]
