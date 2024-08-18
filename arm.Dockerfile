FROM --platform=linux/amd64 alpine:3.20 AS verify
RUN apk add --no-cache libarchive-tools
# Stage 1: Verification
FROM alpine:3.20 AS verify
COPY ArchLinuxARM-armv7-latest.tar.gz /rootfs.tar.gz

COPY ArchLinuxARM-armv7-latest.tar.gz /tmp
RUN mkdir /rootfs && bsdtar -xpf /tmp/ArchLinuxARM-armv7-latest.tar.gz -C /rootfs

FROM scratch as root
COPY --from=verify /rootfs/ /

ENV LANG=C.UTF-8
CMD ["/usr/bin/bash"]