ARG BASE_IMAGE
ARG BASE_TAG

FROM debian:latest as downloader
ARG HUGO_VERSION
WORKDIR /hugo
COPY checksums/hugo_${HUGO_VERSION}_checksums.txt .
ARG TARGETARCH
ARG HUGO_TYPE
ARG HUGO_EXTENDED
ENV HUGO_FILE=hugo_${HUGO_EXTENDED}${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_FILE} ${HUGO_FILE}
RUN sha256sum --ignore-missing --check hugo_${HUGO_VERSION}_checksums.txt \
    && tar xvf ${HUGO_FILE} hugo

FROM ${BASE_IMAGE}:${BASE_TAG}
COPY --from=downloader /hugo/hugo /usr/local/bin/hugo