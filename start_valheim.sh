#!/bin/bash

# valheim_server.x86_64 likes to start in same directory it's located in
cd ${STEAMAPPDIR}/valheimServer

# Check if Valheim Plus config file exist, will store it in persistant storage
if [ ! -e "/home/steam/.config/unity3d/IronGate/Valheim/valheim_plus.cfg" ]; then
    touch /home/steam/.config/unity3d/IronGate/Valheim/valheim_plus.cfg
    ln -s /home/steam/.config/unity3d/IronGate/Valheim/valheim_plus.cfg ./BepInEx/config/
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
