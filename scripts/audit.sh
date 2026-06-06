#!/bin/bash
echo "=== RoboShield Audit ==="
if grep -q "^PermitRootLogin no" /etc/ssh/sshd_config 2>/dev/null; then
 echo "[PASS] Root login disabled"
else
 echo "[FAIL] Root login enabled"
fi
ss -tulnp
