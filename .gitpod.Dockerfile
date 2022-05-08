FROM gitpod/workspace-full:2022-05-05-08-58-22@sha256:c8508f5c257f67a837701bd0f6ecbc32b0ad2f6c54a97ecf551b5cb60f3a616c

USER root

# libgompl is needed to run z3
# but should already be installed
# in gitpod/workspace-full

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      mono-complete \
 && apt-get clean \
 && rm -rf /var/cache/apt/* \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* \
 && rm -rf /var/tmp/*

ARG DAFNY_VERSION=3.5.0
ARG DAFNY_ZIP=dafny-${DAFNY_VERSION}-x64-ubuntu-16.04.zip

RUN \
  cd /tmp \
  && wget https://github.com/dafny-lang/dafny/releases/download/v${DAFNY_VERSION}/${DAFNY_ZIP} \
  && unzip -d /opt/ ${DAFNY_ZIP} \
  && chmod -R +r /opt/dafny


USER gitpod


ENV PATH /opt/dafny:/opt/dafny/z3/bin:${PATH}

