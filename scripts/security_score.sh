#!/bin/bash
echo "=================================="
echo "      RoboShield Security Score"
echo "=================================="
TOTAL=0
if systemctl is-active --quiet ssh; then
    SSH_SCORE=20
else
    SSH_SCORE=10
fi
TOTAL=$((TOTAL + SSH_SCORE))
if command -v ufw >/dev/null && ufw status | grep -q "Status: active"; then
    FW_SCORE=20
else
    FW_SCORE=0
fi
TOTAL=$((TOTAL + FW_SCORE))
if systemctl is-active --quiet usbguard; then
    USB_SCORE=20
else
    USB_SCORE=0
fi
TOTAL=$((TOTAL + USB_SCORE))
if systemctl is-active --quiet fail2ban; then
    FAIL2BAN_SCORE=20
else
    FAIL2BAN_SCORE=0
fi
TOTAL=$((TOTAL + FAIL2BAN_SCORE))
if systemctl is-active --quiet auditd; then
    AUDIT_SCORE=20
else
    AUDIT_SCORE=0
fi
TOTAL=$((TOTAL + AUDIT_SCORE))
echo ""
echo "SSH Hardening : $SSH_SCORE/20"
echo "Firewall      : $FW_SCORE/20"
echo "USB Protection: $USB_SCORE/20"
echo "Fail2Ban      : $FAIL2BAN_SCORE/20"
echo "Audit Logging : $AUDIT_SCORE/20"
echo ""
echo "Overall Score : $TOTAL/100"
