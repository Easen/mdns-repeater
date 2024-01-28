FROM alpine AS builder
ARG MDNS_REPEATER_VERSION=local
ARG HGVERSION=0
ENV HGVERSION=$HGVERSION
ADD mdns-repeater.c mdns-repeater.c
RUN set -ex && \
    apk add build-base && \
    gcc -o /bin/mdns-repeater mdns-repeater.c -DHGVERSION="\"${HGVERSION}\""



FROM alpine
RUN apk --no-cache add libcap
LABEL maintainer="Marc Easen <marc@easen.co.uk"

COPY --from=builder /bin/mdns-repeater /app/mdns-repeater
RUN chown root:root /app/mdns-repeater
RUN chmod +x /app/mdns-repeater
RUN setcap cap_net_raw=+ep /app/mdns-repeater

ADD entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]