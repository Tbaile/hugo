# downloder of bin
FROM debian:latest as downloader
WORKDIR /hugo
# copy checksums of given version
ARG VERSION
COPY checksums/hugo_${VERSION}_checksums.txt .
# get arch
ARG TARGETARCH
ARG EXTENDED
ARG HUGO_FILE=hugo${EXTENDED}_${VERSION}_linux-${TARGETARCH}.tar.gz
ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${HUGO_FILE} ${HUGO_FILE}
RUN sha256sum --ignore-missing --check hugo_${VERSION}_checksums.txt \
    && tar xvf ${HUGO_FILE} hugo
    
FROM alpine:3.18.4 as alpine
COPY --from=downloader /hugo/hugo /usr/local/bin/hugo

FROM debian:12.1 as debian
COPY --from=downloader /hugo/hugo /usr/local/bin/hugo

FROM ubuntu:22.04 as ubuntu
COPY --from=downloader /hugo/hugo /usr/local/bin/hugo