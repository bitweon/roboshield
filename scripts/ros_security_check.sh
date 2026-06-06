#!/bin/bash
echo "=== ROS Security Audit ==="
command -v ros2 >/dev/null && echo "[PASS] ROS2 detected" || echo "[WARN] ROS2 not installed"
