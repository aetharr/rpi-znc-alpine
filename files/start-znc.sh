#!/bin/sh

# First, check that we havent added a bind-mount
if ! diff /home/znc/.znc /home/znc/.znc-data > /dev/null 2>&1;
then
  cp -r /home/znc/.znc-data/* /home/znc/.znc/
fi

# If we can't find the znc.conf file, then copy over the default config.
if [ ! -f "/home/znc/.znc/configs/znc.conf" ];
then
  mkdir -p /home/znc/.znc/configs
  cp /home/znc/default.conf /home/znc/.znc/configs/znc.conf
fi

/usr/local/bin/znc --foreground
