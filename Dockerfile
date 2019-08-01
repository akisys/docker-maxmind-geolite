FROM buildpack-deps:curl

ARG VERSION="4.0.3"

WORKDIR /tmp
RUN set -ex \
    && wget -O geoipupdate.tgz https://github.com/maxmind/geoipupdate/releases/download/v${VERSION}/geoipupdate_${VERSION}_linux_amd64.tar.gz \
    && mkdir /geoipupdate \
    && tar -xv --strip-components 1 -C/geoipupdate -f geoipupdate.tgz \
    && ln -snf /geoipupdate/GeoIP.conf /usr/local/etc/GeoIP.conf \
    && ln -snf /geoipupdate/geoipupdate /usr/local/bin/geoipupdate \
    && rm -rf /tmp/*

WORKDIR /root
RUN set -ex \
    && mkdir -p /usr/local/share/GeoIP \
    && apt-get update \
    && apt-get install -y --no-install-recommends cron \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN set -ex \
    && chmod +x /entrypoint.sh

ENV CRONTIMER="* * * * *"
ENTRYPOINT ["/bin/sh"]
CMD ["/entrypoint.sh"]

VOLUME /usr/local/share/GeoIP
