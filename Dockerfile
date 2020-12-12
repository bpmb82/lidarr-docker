FROM bpmbee/mono-base:latest

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
        jq xml-twig-tools libchromaprint-tools && \
 echo "**** install sonarr ****" && \
 LIDARR_RELEASE=$(curl -sL "https://lidarr.servarr.com/v1/update/master/changes?os=linux" | jq -r '.[0].version') && \
 curl -L -o /opt/lidarr.tar.gz https://github.com/lidarr/Lidarr/releases/download/v${LIDARR_RELEASE}/Lidarr.master.$LIDARR_RELEASE.linux.tar.gz && \
 cd /opt && \
 tar zxvf lidarr.tar.gz && \
 rm lidarr.tar.gz && \
 echo "**** cleanup ****" && \
 apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
 rm -rf \
        /tmp/* \
        /var/tmp/*

WORKDIR /opt
COPY start.sh .
COPY healthcheck.sh .
RUN chmod +x *.sh

EXPOSE 8686
VOLUME /config

HEALTHCHECK --interval=5m --timeout=5s \
  CMD /opt/healthcheck.sh

ENTRYPOINT ["/opt/start.sh"]
