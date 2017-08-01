FROM cmp1234/python:2.7.13-alpine3.6

RUN set -ex; \
	\
 apk add --no-cache --virtual .build-deps \
		libressl-dev \
		gcc \
		linux-headers \
		musl-dev \
		zlib \
		zlib-dev \
		openssl \
		openssl-dev \
	; \
  deps=' \
            pycrypto==2.6.1 \
            paramiko==1.17.0 \
            click==6.7 \
            Jinja2==2.8 \
            PyYAML==3.11 \
        '; \
  pip install $deps; \
  \
  apk del .build-deps;
