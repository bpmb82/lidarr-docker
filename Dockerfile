FROM bpmbee/mono-base:latest

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
        jq xml-twig-tools && \
 echo "**** install sonarr ****" && \
 LIDARR_VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/lidarr/Lidarr/releases/latest | awk -F / '{print $NF}') && \
 curl -L -o /opt/lidarr.tar.gz https://github.com/lidarr/lidarr/archive/${LIDARR_VERSION}.tar.gz && \
 cd /opt && \
 tar zxvf lidarr.tar.gz && \
 rm lidarr.tar.gz && \
 LIDARR_DIR=$(ls | grep Lidarr*) && \
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

EXPOSE 7878
VOLUME /config

HEALTHCHECK --interval=5m --timeout=5s \
  CMD /opt/healthcheck.sh

ENTRYPOINT ["/opt/start.sh"]
