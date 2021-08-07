FROM openjdk:8-jre-alpine AS minecraft-server

EXPOSE 25565

WORKDIR /forges
RUN set -x && \
  wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2855/forge-1.12.2-14.23.5.2855-installer.jar -O forge-installer.jar && \
  java -jar ./forge-installer.jar nogui --installServer


WORKDIR /
COPY ./forge-start.sh ./forge-start.sh

WORKDIR /var/server-contents
ENTRYPOINT ["/forge-start.sh"]
CMD ["4096", "8192"]
