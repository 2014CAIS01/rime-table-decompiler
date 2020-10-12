FROM alpine:latest AS builder
LABEL maintainer="cubercsl <cubercsl@163.com>"
LABEL description="An environment with Boost C++ Libraries based on Alpine Linux."

ARG BOOST_VERSION=1.67.0
ARG BOOST_DIR=boost_1_67_0
ENV BOOST_VERSION ${BOOST_VERSION}

# Use bzip2-dev package for Boost IOStreams library support of zip and bzip2 formats
# Use openssl package for wget ssl_helper issue
RUN apk add --no-cache --virtual .build-dependencies \
    openssl \
    linux-headers \
    build-base \
    && wget http://downloads.sourceforge.net/project/boost/boost/${BOOST_VERSION}/${BOOST_DIR}.tar.bz2 \
    && tar --bzip2 -xf ${BOOST_DIR}.tar.bz2 \
    && cd ${BOOST_DIR} \
    && ./bootstrap.sh \
    && ./b2 --without-python --prefix=/usr -j 4 link=static runtime-link=static install \
    && cd .. && rm -rf ${BOOST_DIR} ${BOOST_DIR}.tar.bz2 \
    && apk del .build-dependencies

RUN apk add build-base
RUN apk add cmake

COPY src /root/src
RUN mkdir /root/src/build
WORKDIR /root/src/build
RUN cmake ..
RUN make

FROM alpine:latest
RUN apk update && apk add --no-cache libstdc++ libgcc
COPY --from=builder /root/src/build/rime_table_bin_decompiler rime_table_bin_decompiler
VOLUME [ "/data" ]
ENTRYPOINT ["./rime_table_bin_decompiler"]