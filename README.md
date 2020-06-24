This build of ZNC is simple to setup, it already has a config file built in that you can tweak after the fact if you create a volume (Use of a volume is not required, but is recommended).

This image contains the same features as my [other ZNC container](https://github.com/aetharr/rpi-znc), but is based on an Alpine Linux image.

This has been tested on a Raspberry Pi 3 running Docker 19.3.11

## Updates
* 23/06/2020
  * Updated the link to the weblog plugin as the old one doesnt seem to exist anymore.
  * Updated the base image to use the official Alpine image as it's more up-to-date and also supports ARMv7.
  * Fixed an oversight where the default user account was set to use /bin/bash when it should be /bin/sh.
* 11/07/2018
  * There are now 2 versions of this image on seperate branches `master` and `weblog`
  * The base (master) container is simply all you need to get started with ZNC at all, nothing fancy.
  * The Weblog container includes a Python3 install and the Weblog module to allow chatlogs to be viewed in the web admin.
  * The config file has been updated to include the Version parameter which was preventing the container from building previously

## Running the bouncer
```bash
docker run -d -p 8080:8080 aetharr/rpi-znc-alpine
```

## Regarding the Config File
When the container has been run for the first time, it will detect whether there is a config file in the appropriate place and if not, add the default one.
This allows you to specify one using a volume for easier access if you wish. It will not create one if a `ZNC.conf` file already exists.

## Using a Volume
If you'd like to map the ZNC config directory to a volume or bind mount, then the ZNC config data is located at `~/.znc`.
```bash
docker run -d  -v $HOME/znc:/home/znc/.znc -p 8080:8080 aetharr/rpi-znc-alpine
```

## Going Forward
To configure the bouncer while running, visit `http://<hostname>:8080`
The default login details are:
```
u: admin
p: password
```

To connect an IRC client to the bouncer, you can connect to `http://<hostname>:8080` too for simplicity.


## Troubleshooting

### Permission issues
If you're finding that when using a bind-mount, that ZNC doesn't have permission to access the config files. You can pass the `--user xx:xx` argument when launching your docker container.

It can use either a username and groupname OR a user Id and group Id. Just set this to the same one as your host files' uid:gid and you should be good to go!