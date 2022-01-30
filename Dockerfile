FROM cm2network/steamcmd:root

ENV STEAMAPPID 896660
ENV STEAMAPP valheim
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"

RUN apt update && apt install file -y \
  && groupadd --gid 1007 valheim \
  && usermod -aG valheim steam \
  && mkdir -p ${STEAMAPPDIR}/valheimServer ${HOMEDIR}/.config/unity3d/IronGate/Valheim \
  && chown -R "steam:valheim" "${STEAMAPPDIR}" "${HOMEDIR}/.config"

WORKDIR $STEAMAPPDIR
# Download Valheim Server from steam CLI
RUN ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir $STEAMAPPDIR/valheimServer +app_update $STEAMAPPID +quit
# Download Valheim Plus Server, if updates the version in URL will need to change
RUN curl -o $STEAMAPPDIR/valheimServer/valheimPlus.tar.gz https://valheim.plus/cdn/0.9.9.6/UnixServer.tar.gz \
  && tar xzvf $STEAMAPPDIR/valheimServer/valheimPlus.tar.gz -C $STEAMAPPDIR/valheimServer

COPY ./start_valheim.sh .
RUN chmod +x "${STEAMAPPDIR}/start_valheim.sh" "${STEAMAPPDIR}/valheimServer/start_server_bepinex.sh" \
    && chown -R "steam:valheim" "${STEAMAPPDIR}/start_valheim.sh" "${STEAMAPPDIR}" \
        "${HOMEDIR}/.config"

VOLUME /home/steam/.config/unity3d/IronGate/Valheim

USER steam
CMD ["./start_valheim.sh"]
