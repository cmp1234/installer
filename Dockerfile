FROM cmp1234/python-jre:2.7.13-8u131-alpine3.6

RUN set -ex; \
	\
 apk add --no-cache --virtual .build-deps \
		coreutils \
		gcc \
		curl \
		linux-headers \
		make \
		python2-dev \
		python3-dev \
		musl-dev \
		zlib \
		zlib-dev \
		openssl \
		openssl-dev \
	; \
  apk add --no-cache curl; \
  deps=' \
            pycrypto==2.6.1 \
            paramiko==1.17.0 \
            click==6.7 \
            Jinja2==2.8 \
            PyYAML==3.11 \
	    ansible==2.2.1.0 \
        '; \
  pip install $deps; \
  \
  apk del .build-deps;
