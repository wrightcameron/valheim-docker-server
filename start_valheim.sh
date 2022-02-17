#!/bin/bash

# valheim_server.x86_64 likes to start in same directory it's located in
cd ${STEAMAPPDIR}/valheimServer

saveDir="/home/steam/.config/unity3d/IronGate/Valheim"
# Check if Valheim Plus config file exist, will store it in persistant storage
if [ ! -e "${saveDir}/valheim_plus.cfg" ]; then
    touch ${saveDir}/valheim_plus.cfg
    ln -s ${saveDir}/valheim_plus.cfg ./BepInEx/config/
fi

# Check if Valheim Plus plugin directory exists, if not move to persistant storage for user
if [ ! -d "${saveDir}/plugins" ]; then
        cp -r ./BepInEx/plugins ${saveDir}/plugins
        ln -s ${saveDir}/plugins ./BepInEx/config/plugins
fi


./start_server_bepinex.sh \
    -name $SERVER_NAME \
    -port $SERVER_PORT \
    -world $SERVER_WORLD \
    -password $SERVER_PASSWORD \
    -public 1 &

# Trap SIGTERM and perform safe shutdown
trap "kill -s SIGINT $!; wait" SIGTERM

# Wait for the job to end
wait $!

