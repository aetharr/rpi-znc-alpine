FROM alpine

LABEL maintainer="AEtharr <aetharr@gmail.com>"

# Prepare the Image for building ZNC from source
RUN apk update && \
    apk add alpine-sdk && \
    apk add wget && \
    apk add icu-dev && \
    apk add openssl-dev && \
    wget https://znc.in/releases/archive/znc-1.8.1.tar.gz --no-check-certificate && \
    tar -zxf znc-latest.tar.gz && \
    cd znc* && \
    ./configure && make && make install && \
    rm -rf /znc* && \
    \
    apk del -r --purge alpine-sdk && \
    apk del -r --purge openssl-dev && \
    \
    adduser -D -s /bin/sh -h /home/znc znc

# Copy in our default config and startup script
COPY ./files/start-znc.sh /usr/local/bin/
COPY ./files/default.conf /home/znc/

# Make sure that the ZNC user has permission to use the config
RUN chown znc:znc /home/znc/default.conf

# Actually create the .znc folder with relative permissions
# RUN mkdir -p /home/znc/.znc && \
RUN mkdir -p /home/znc/.znc-initial && \
    mkdir -p /home/znc/.znc && \
    chown znc:znc -Rf /home/znc/.znc-initial /home/znc/.znc

USER znc

WORKDIR /home/znc

ENTRYPOINT ["/usr/local/bin/start-znc.sh"]

EXPOSE 8080
