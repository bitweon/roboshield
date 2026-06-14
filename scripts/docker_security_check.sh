#!/bin/bash

echo "=== Docker Security Audit ==="

if ! command -v docker >/dev/null 2>&1; then
    echo "[!] Docker not installed"
    exit 1
fi

echo
echo "[+] Docker version"
docker --version

echo
echo "[+] Running containers"
docker ps

echo
echo "[+] Privileged containers"

docker ps -q | while read c; do
    privileged=$(docker inspect "$c" --format '{{.HostConfig.Privileged}}')

    if [ "$privileged" = "true" ]; then
        name=$(docker inspect "$c" --format '{{.Name}}')
        echo "[HIGH] $name is running privileged"
    fi
done

echo
echo "[+] Containers running as root"

docker ps -q | while read c; do
    user=$(docker inspect "$c" --format '{{.Config.User}}')

    if [ -z "$user" ] || [ "$user" = "0" ]; then
        name=$(docker inspect "$c" --format '{{.Name}}')
        echo "[MEDIUM] $name may run as root"
    fi
done

echo
echo "[+] Host network containers"

docker ps -q | while read c; do
    net=$(docker inspect "$c" --format '{{.HostConfig.NetworkMode}}')

    if [ "$net" = "host" ]; then
        name=$(docker inspect "$c" --format '{{.Name}}')
        echo "[MEDIUM] $name uses host networking"
    fi
done
