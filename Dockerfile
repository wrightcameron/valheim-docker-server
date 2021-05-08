FROM cm2network/steamcmd:root

ENV STEAMAPPID 896660
ENV STEAMAPP valheim
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"

WORKDIR $STEAMAPPDIR
COPY ./start_valheim.sh .
RUN mkdir "${STEAMAPPDIR}/valheimServer"
RUN chmod +x "${STEAMAPPDIR}/start_valheim.sh" \
    && chown -R "${USER}:${USER}" "${STEAMAPPDIR}/start_valheim.sh" "${STEAMAPPDIR}"

CMD ["./start_valheim.sh"]
