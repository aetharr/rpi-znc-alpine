#!/bin/sh

# First check that the .znc folder doesnt exist already
if [! -d "/home/znc/.znc" ];
then
  echo "~/.znc folder NOT FOUND. Creating..."
  mkdir -p /home/znc/.znc/
else
  echo "~/.znc folder FOUND"
fi

# Now check for the config file. If it exists, then we can start.
# If not, then copy over the initial files.
if [ ! -f "/home/znc/.znc/configs/znc.conf" ];
then
  echo "znc.conf file NOT FOUND. Copying initial files..."
  cp -r /home/znc/.znc-initial/* /home/znc/.znc/
  echo "Creating default config."
  echo "Login with:"
  echo "u: admin"
  echo "p: password"
  echo ""
  echo "CHANGE THIS!"
  mkdir -p /home/znc/.znc/configs
  cp /home/znc/default.conf /home/znc/.znc/configs/znc.conf
else
  echo "znc.conf file FOUND."
fi

/usr/local/bin/znc --foreground
