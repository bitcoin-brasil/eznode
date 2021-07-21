# debian:10-slim
ARG BASE_IMAGE=debian@sha256:7f5c2603ccccb7fa4fc934bad5494ee9f47a5708ed0233f5cd9200fe616002ad
FROM $BASE_IMAGE

# See the 'docker' directory for arm32v7/arm64v8

# Build settings
ARG INSTALL=bitcoind,bwt,btc-rpc-explorer,specter,tor,nginx,letsencrypt,dropbear
ARG DEV

ARG BWT_VERSION=0.2.4
ARG BWT_ARCH=x86_64-linux
ARG BWT_SHA256=a98fc1820e53d928d58253c9e45327deb6339f30afe443350d29662937095c0f

ARG BITCOIND_VERSION=0.21.1
ARG BITCOIND_ARCH=x86_64-linux-gnu
ARG BITCOIND_SHA256=366eb44a7a0aa5bd342deea215ec19a184a11f2ca22220304ebb20b9c8917e2b

ARG BTCEXP_COMMIT=133ff397c39eef86185cc66ea1a9fa64567fb824
ARG BTCEXP_SHA256=e0aa7497682dc626e0d10f429916e882162fdbce94efff02a88a0ebdce19e8f0

ARG SPECTER_VERSION=1.5.0
ARG SPECTER_SHA256=c90a142bd34a4e9b8d0cf4339fc9209937121c8faef8a0f8ccc52750cab4c8a7

ARG S6_OVERLAY_VERSION=2.2.0.1
ARG S6_OVERLAY_ARCH=amd64
ARG S6_OVERLAY_SHA256=2dcb59b63d1d0f5f056d4e10d6cbae21a9c216e130080d3b5aaa8e7325ac571b

ARG NODEJS_VERSION=14.15.5
ARG NODEJS_ARCH=linux-x64
ARG NODEJS_SHA256=e30c1fd4807fba052c209d7577bb6b63b5096d67c1b9ac753b9d502fda43ded9

COPY . /tmp/setup
RUN (cd /tmp/setup && ./install.sh) && rm -r /tmp/*

# Runtime settings
ENV NETWORK=bitcoin
ENV BWT=1
ENV EXPLORER=1
ENV SPECTER=0
ENV TOR=0
ENV SSL=0
ENV SSHD=0
ENV BWT_LOGS=1

ENV PATH=/ez/bin:$PATH
ENTRYPOINT ["/ez/entrypoint.sh"]
