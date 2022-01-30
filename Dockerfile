FROM cm2network/steamcmd:root

ENV STEAMAPPID 896660
ENV STEAMAPP valheim
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"

RUN apt update && apt install file -y

WORKDIR $STEAMAPPDIR
RUN groupadd --gid 1007 valheim \
  && usermod -aG valheim steam
RUN mkdir -p ${STEAMAPPDIR}/valheimServer ${HOMEDIR}/.config/unity3d/IronGate/Valheim
RUN chown -R "steam:valheim" "${STEAMAPPDIR}" "${HOMEDIR}/.config"
RUN ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir $STEAMAPPDIR/valheimServer +app_update $STEAMAPPID +quit

COPY ./start_valheim.sh .
RUN chmod +x "${STEAMAPPDIR}/start_valheim.sh" \
    && chown -R "steam:valheim" "${STEAMAPPDIR}/start_valheim.sh" "${STEAMAPPDIR}" \
        "${HOMEDIR}/.config"

# Setup Valheim Plus
WORKDIR $STEAMAPPDIR/valheimServer
RUN curl -O https://valheim.plus/cdn/0.9.9.6/UnixServer.tar.gz
RUN tar xzvf UnixServer.tar.gz

RUN chmod +x "${STEAMAPPDIR}/start_valheim.sh" "${STEAMAPPDIR}/valheimServer/start_server_bepinex.sh"\
    && chown -R "steam:valheim" "${STEAMAPPDIR}/start_valheim.sh" "${STEAMAPPDIR}" "${HOMEDIR}/.config"

WORKDIR $STEAMAPPDIR
VOLUME /home/steam/.config/unity3d/IronGate/Valheim

USER steam
CMD ["./start_valheim.sh"]
