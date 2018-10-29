FROM ubuntu:xenial

RUN \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
		automake \
		build-essential \
		libedit-dev \
		libjemalloc-dev \
		libncurses-dev \
		libpcre3-dev \
		libtool \
		pkg-config \
		python-docutils \
		python-sphinx \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV VARNISH_VERSION 6.1.0
ENV VARNISH_FILENAME varnish-6.1.0.tgz
ENV VARNISH_SHA256 161b92519801240886a55cc27484efc995dde1ad4703d9afd49fa8f32656e27d

RUN set -xe \
	&& curl -fSL "https://varnish-cache.org/_downloads/varnish-6.1.0.tgz" -o $VARNISH_FILENAME \
	&& echo "$VARNISH_SHA256 *$VARNISH_FILENAME" | sha256sum -c - \
	&& mkdir -p /usr/local/src \
	&& tar -xzf "$VARNISH_FILENAME" -C /usr/local/src \
	&& mv "/usr/local/src/varnish-$VARNISH_VERSION" /usr/local/src/varnish \
	&& rm "$VARNISH_FILENAME" \
	&& cd /usr/local/src/varnish \
	&& ./autogen.sh \
	&& ./configure \
	&& make install \
	&& ldconfig

COPY start-varnishd.sh /usr/local/bin/start-varnishd

RUN \
	chmod +x /usr/local/bin/start-varnishd \
	&& mkdir /varnishfs \
	&& chgrp -R 0 /varnishfs \
	&& chmod -R g+rwX /varnishfs

ENV VARNISH_HOST 0.0.0.0
ENV VARNISH_PORT 6081
ENV VCL_CONFIG /etc/varnish/default.vcl
ENV VARNISH_MEMORY 100m

EXPOSE 6081

CMD ["start-varnishd"]
