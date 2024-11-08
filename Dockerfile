FROM alpine:latest
ADD --chown=root:root sshd_config /etc/ssh/sshd_config
ADD --chown=root:root entrypoint.sh /entrypoint.sh
RUN apk add --no-cache openssh-server \
  && mkdir /jail \
  && mkdir -p /workspace/etc/ssh /workspace/keys \
  && addgroup -S ssh-user \
  && adduser -s /bin/true -S ssh-user -G ssh-user \
  && chown -R ssh-user:ssh-user /workspace/ /jail \
  && chmod 555 /entrypoint.sh
USER ssh-user
EXPOSE 2222
ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]