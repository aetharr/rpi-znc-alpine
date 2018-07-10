FROM hypriot/rpi-alpine-scratch

LABEL maintainer="AEtharr <aetharr@gmail.com>"

# Prepare the Image for building ZNC from source
RUN apk update && \
    apk add alpine-sdk && \
    apk add wget && \
    apk add icu-dev && \
    apk add openssl-dev && \

    apk add python3 && \
    apk add python3-dev && \
    apk add perl && \

    wget http://znc.in/releases/znc-latest.tar.gz --no-check-certificate && \
    tar -zxf znc-latest.tar.gz && \
    cd znc* && \
    ./configure --enable-python && \
    make && make install && \

    apk del -r --purge alpine-sdk && \
    apk del -r --purge openssl-dev && \

    adduser -D -s /bin/bash -h /home/znc znc

# Add the weblog plugin to the mix
RUN wget https://github.com/MuffinMedic/znc-weblog/archive/master.zip --no-check-certificate && \
    mv master.zip znc-weblog.zip && \
    unzip -q znc-weblog.zip && \
    mkdir /usr/local/znc && \
    mkdir /usr/local/znc/weblog && \
    cd znc-weblog* && \
    mv tmpl /usr/local/lib/znc/weblog/ && \
    mv weblog.py /usr/local/lib/znc && \
    chmod +x /usr/local/lib/znc/weblog.py

# Copy in our default config and startup script
COPY ./files/start-znc.sh /usr/local/bin/
COPY ./files/default.conf /home/znc/

# Make sure that the ZNC user has permission to use the config
RUN chown znc:znc /home/znc/default.conf

# Actually create the .znc folder with relative permissions
RUN mkdir -p /home/znc/.znc && \
    chown znc:znc -Rf /home/znc/.znc

USER znc

WORKDIR /home/znc

ENTRYPOINT ["/usr/local/bin/start-znc.sh"]

EXPOSE 8080
