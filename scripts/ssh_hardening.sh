#!/bin/bash
SSHD="/etc/ssh/sshd_config"
cp "$SSHD" "$SSHD.bak"
sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' "$SSHD"
systemctl restart ssh || systemctl restart sshd
