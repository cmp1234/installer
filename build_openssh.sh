#!/bin/sh

set -x

PREFIX=/usr/local/openssh

OPENSSH=openssh-7.4p1
ZLIB=zlib-1.2.11
OPENSSL=openssl-1.0.2p

ZLIB_PKG=${ZLIB}.tar.gz
OPENSSL_PKG=${OPENSSL}.tar.gz
OPENSSH_PKG=${OPENSSH}.tar.gz

ZLIB_DOWNLOAD_URL=http://zlib.net
OPENSSL_DOWNLOAD_URL=http://www.openssl.org/source
OPENSSH_DOWNLOAD_URL=http://mirrors.sonic.net/pub/OpenBSD/OpenSSH/portable

rm -rf $PREFIX 
mkdir $PREFIX

rm -rf src 
mkdir src

rm openssh -rf

cd src

curl -OLk $ZLIB_DOWNLOAD_URL/$ZLIB_PKG && tar xf $ZLIB_PKG
curl -OLk $OPENSSL_DOWNLOAD_URL/$OPENSSL_PKG && tar xf $OPENSSL_PKG
curl -OLk $OPENSSH_DOWNLOAD_URL/$OPENSSH_PKG && tar xf $OPENSSH_PKG

cd $OPENSSL && ./config && make && make install && make clean
cd ../$OPENSSH

./configure --prefix=$PREFIX --with-zlib=../$ZLIB --with-ssl-dir=../$OPENSSL && make \
&& make install \
&& cp contrib/ssh-copy-id /usr/local/bin/ \
&& chmod +x /usr/local/bin/ssh-copy-id \
&& cd ../.. \
&& rm -rf src \
&& rm -rf $PREFIX/libexec $PREFIX/sbin
