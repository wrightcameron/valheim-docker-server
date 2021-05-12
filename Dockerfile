FROM cm2network/steamcmd:root

ENV STEAMAPPID 896660
ENV STEAMAPP valheim
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"

WORKDIR $STEAMAPPDIR
COPY ./start_valheim.sh .
RUN mkdir -p ${STEAMAPPDIR}/valheimServer ${HOMEDIR}/.config/unity3d/IronGate/Valheim
RUN chmod +x "${STEAMAPPDIR}/start_valheim.sh" \
    && chown -R "steam:steam" "${STEAMAPPDIR}/start_valheim.sh" "${STEAMAPPDIR}" \
        "${HOMEDIR}/.config"

USER steam
CMD ["./start_valheim.sh"]