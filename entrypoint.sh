#!/bin/sh
# Generate new SSH host keys
ssh-keygen -A -f /workspace

# Ensure that the ssh-user has a .ssh directory
mkdir -p /home/ssh-user/.ssh

# Add files in workspace keys directroy to the users ssh authorized keys
# if folder is empty, this will not fail
find /workspace/keys -type f -exec cat {} >> /home/ssh-user/.ssh/authorized_keys \;

# Start the SSH server
/usr/sbin/sshd -D -e
