#!/bin/bash
${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir $STEAMAPPDIR/valheimServer +app_update $STEAMAPPID +quit

# valheim_server.x86_64 likes to start in same directory it's located in
cd ${STEAMAPPDIR}/valheimServer

./valheim_server.x86_64 \
    -name $SERVER_NAME \
    -port $SERVER_PORT \
    -world $SERVER_WORLD \
    -password $SERVER_PASSWORD \
    -public 1 &

# Trap SIGTERM and perform safe shutdown
trap "kill -s SIGINT $!; wait" SIGTERM

# Wait for the job to end
wait $!