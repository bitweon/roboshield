#!/bin/bash
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw enable
