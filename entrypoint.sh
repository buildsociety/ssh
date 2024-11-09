#!/bin/sh
set -e

# Logging function
log() {
    echo "$(date +"%Y-%m-%d %T") - $1"
}

log "Generating new SSH host keys"
ssh-keygen -A -f /workspace

log "Ensuring ssh-user has a .ssh directory"
mkdir -p /home/ssh-user/.ssh

log "Adding files in workspace keys directory to the user's ssh authorized keys"
if find /workspace/keys -type f -exec cat {} >> /home/ssh-user/.ssh/authorized_keys; echo "" >> /home/ssh-user/.ssh/authorized_keys \;; then
    log "Authorized keys updated."
else
    log "No keys found in /workspace/keys."
fi

log "Starting the SSH server in the foreground"
/usr/sbin/sshd -D -e