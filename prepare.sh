#!/bin/bash

set -e

echo "UPDATING SYSTEM"
sudo apt update -qqq && sudo apt -qqq -o Dpkg::Use-Pty=0 upgrade -y && sudo apt -qqq -o Dpkg::Use-Pty=0 dist-upgrade -y
sudo apt -qqq -o Dpkg::Use-Pty=0 install git software-properties-common python3 python-is-python3 python3-pip -y

echo "INSTALL ANSIBLE"
pip --quiet install --no-warn-script-location --user ansible

