#!/bin/bash

set -e

echo "UPDATING SYSTEM"
sudo apt update -qqq && sudo apt -qqq -o Dpkg::Use-Pty=0 upgrade -y && sudo apt -qqq -o Dpkg::Use-Pty=0 dist-upgrade -y
sudo apt -qqq -o Dpkg::Use-Pty=0 install git software-properties-common python3 python3-venv python-is-python3 python3-pip -y

echo "INSTALL PIPX"
sudo pip -q install pipx --break-system-packages
pipx -q ensurepath
sudo pipx -q ensurepath --global
# sudo -H pip --quiet install --no-warn-script-location  ansible ansible-lint
echo "INSTALL ANIBLE"
sudo pipx -q install --global --include-deps ansible

