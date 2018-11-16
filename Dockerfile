FROM cmp1234/python-jre:2.7.13-8u131-alpine3.6

COPY build_openssh.sh /build_openssh.sh 

RUN set -ex; \
 chmod +x /build_openssh.sh; \
 apk update \
 apk add --no-cache --virtual .build-deps \
		coreutils \
		bash \
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
		perl \
		libffi \
		libffi-dev \
		tar \
	; \
  apk add --no-cache curl libcrypto1.0 sshpass python; \
  /build_openssh.sh; \
  deps=' \
            pycrypto==2.6.1 \
            paramiko==1.17.6 \
            click==6.7 \
            Jinja2==2.8 \
            PyYAML==3.11 \
	    ansible==2.4.1.0 \
	    pexpect==4.2.1 \
	    docker \
	    pyaml \
	    zabbix-api==0.5.3 \
        '; \
  pip install $deps; \
  curl -ko /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.10.0/bin/linux/amd64/kubectl \
  chmode +x /usr/bin/kubectl \
  \
  apk del .build-deps; \
  ln -s /usr/local/bin/bash /bin/bash; \
  rm -f /build_openssh.sh; 
