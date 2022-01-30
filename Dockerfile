FROM cm2network/steamcmd:root

ENV STEAMAPPID 896660
ENV STEAMAPP valheim
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"

WORKDIR $STEAMAPPDIR
RUN groupadd --gid 1007 valheim \
  && usermod -aG valheim steam
RUN mkdir -p ${STEAMAPPDIR}/valheimServer ${HOMEDIR}/.config/unity3d/IronGate/Valheim
COPY ./start_valheim.sh .
RUN chmod +x "${STEAMAPPDIR}/start_valheim.sh" \
    && chown -R "steam:valheim" "${STEAMAPPDIR}/start_valheim.sh" "${STEAMAPPDIR}" \
        "${HOMEDIR}/.config"
RUN ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir $STEAMAPPDIR/valheimServer +app_update $STEAMAPPID +quit

VOLUME /home/steam/.config/unity3d/IronGate/Valheim

USER steam
CMD ["./start_valheim.sh"]
