# Valheim Docker Server
Dedicated server for [Valheim](https://store.steampowered.com/app/892970/Valheim/).

## About
Dedicated Docker image for video game Valheim.  No mods are included with image.  This image is self contained, with everything needed to standup a Valheim headless dedicated server.

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

## Volumes
Server uses two volumes. The server files use a docker volume while the persistant data like admins, bans, map are a bind mount.

The server files mount is optional, but if the server is expected to be started and stopped serveral times, this volume will insure that Steam CMD doesn't constantly have to redownload Valheim every single time the container starts up.

### Permissions

## Usage

### Docker Compose
The docker-compose.yaml is included. Use `docker-compose up -d` to bring up the server, and then `docker-compose down` to bring the server down.

### Docker CLI
```bash
docker run -it --rm \
    --name valheim-server \
    --env SERVER_NAME="My server" \
    --env SERVER_PASSWORD="secret" \
    --env SERVER_PORT=2456 \
    --env SERVER_WORLD=Dedicated \
    -p 2456-2457:2456-2457/udp \
    --volume=valheim_server:/home/steam/valheim/valheimServer \
    --volume=/opt/valheim/data:/root/.config/unity3d/IronGate/Valheim \
    -d wrightcameron/valheim-server
```

While running Docker Compose or Docker CLI interactively (not `-d` mode), you can simply press `CTRL+C` once to gracefully stop the server.

## Shoutouts
These people and resources helped me get this working.
* NobleKangaroo: https://github.com/NobleKangaroo/docker-valheim-server
* SteamCMD image: https://github.com/CM2Walki/steamcmd