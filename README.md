# Setup

## Repo setup
```shell
git config --local include.path ../.gitconfig 
```

## setup new machine
```shell
git clone https://github.com/ppfenning92/setup.git
./setup/prepare.sh
./.local/bin/ansible-playbook setup/init.yml --ask-become-pass
```
