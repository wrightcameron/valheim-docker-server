# Valheim Docker Server

Dedicated server for [Valheim](https://store.steampowered.com/app/892970/Valheim/), with [Valheim Plus](https://valheim.plus/).

## About

Dedicated Docker image for video game Valheim.  Valheim Plus is added for additional server configuration, so players will need to download Valheim Plus client.  This image is self contained, with everything needed to stand up a Valheim headless dedicated server.

The base image this was built upon is a docker image containing just the steam CMD.  Resulting in a very minimal amount of code needed to setup Valheim.

## Build

If you are pulling down this repo and building the image yourself, use `docker build -t valheim-server .`

## Environment Variables

There are four environment variables you can configure:

Variable        | Default        | Description
--------------- | -------------- | --------------------------------------------------
SERVER_NAME     | Valheim Server | The name displayed in the server list
SERVER_PASSWORD | 1234           | The password required to join the server. *Cannot be blank!*
SERVER_PORT     | 2456           | The *first* of to sequential ports the server will use
SERVER_WORLD    | Valheim        | The name of the world file (e.g. Valheim.fwl and Valheim.db)

## Network

The network port is set in the Docker compose file or in the Docker command from CMI.  The default port range is 2456-2457 udp.  If standing up multiple Valheim servers, change the ports (along with map used).

## Volume

Persistent data like admins, bans, map are stored in a volume.  By default Dockerfile creates this unnamed volume.  With docker-compose this volume can be changed to a bind mount.

## Usage

### Docker Compose

The docker-compose.yaml is included. Use `docker-compose up -d` to bring up the server, and then `docker-compose down` to bring the server down.

### Docker CLI

```bash
docker run -it --rm \
    --name valheim-server \
    --env SERVER_NAME="myServer" \
    --env SERVER_PASSWORD="secret" \
    --env SERVER_PORT=2456 \
    --env SERVER_WORLD=Dedicated \
    -p 2456-2457:2456-2457/udp \
    --volume=/opt/valheim/data:/steam/.config/unity3d/IronGate/Valheim \
    -d wrightcameron/valheim-server
```

While running Docker Compose or Docker CLI interactively (not `-d` mode), you can simply press `CTRL+C` once to gracefully stop the server.

## Shout-outs

These people and resources helped me get this working.

* [NobleKangaroo example image](https://github.com/NobleKangaroo/docker-valheim-server)
* [SteamCMD image](https://github.com/CM2Walki/steamcmd)
