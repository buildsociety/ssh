FROM alpine:latest
ADD --chown=root:root sshd_config /etc/ssh/sshd_config
ADD --chown=root:root entrypoint.sh /entrypoint.sh
RUN apk upgrade --no-cache \
  && apk add --no-cache openssh-server tini \
  && mkdir -p /workspace/etc/ssh /workspace/keys \
  && addgroup -S ssh-user \
  && adduser -S ssh-user -G ssh-user \
  && chown -R ssh-user:ssh-user /workspace/ \
  && chmod 555 /entrypoint.sh
USER ssh-user
EXPOSE 2222
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD nc -z localhost 2222 || exit 1
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/entrypoint.sh"]