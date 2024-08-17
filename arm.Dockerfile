# Stage 1: Verification
FROM alpine:3.20 AS verify
COPY ArchLinuxARM-armv7-latest.tar.gz /rootfs.tar.gz

RUN apk add --no-cache curl tar zstd && \
    mkdir /rootfs && \
    tar -C /rootfs --extract --file /rootfs.tar.gz

# Stage 2: Setup Arch Linux ARM
FROM scratch AS root

LABEL org.opencontainers.image.title="Arch Linux ARM"
LABEL org.opencontainers.image.description="UnOfficial container image of Arch Linux ARM, a simple, lightweight Linux distribution aimed for flexibility."
LABEL org.opencontainers.image.authors="spark <admin@saybackend.com>"
LABEL org.opencontainers.image.url="https://saybackend.com/"
LABEL org.opencontainers.image.documentation="https://wiki.archlinux.org/title/Docker#Arch_Linux"
LABEL org.opencontainers.image.source="https://github.com/spa5k/archlinux-wsl"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"
LABEL org.opencontainers.image.version="latest"
LABEL org.opencontainers.image.revision="1"
LABEL org.opencontainers.image.created="2024-08-17"

COPY --from=verify /rootfs/ /

RUN ldconfig && \
    sed -i '/BUILD_ID/a VERSION_ID=latest' /etc/os-release

ENV LANG=C.UTF-8
CMD ["/usr/bin/bash"]
