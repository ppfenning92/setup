# Setup

## Repo setup

```shell
git config --local include.path ../.gitconfig
```

## setup new machine

```shell
git clone https://github.com/ppfenning92/setup.git
./setup/prepare.sh
ansible-playbook setup/init.yml --ask-become-pass --ask-vault-pass

# testing inside docker
ansible-playbook setup/init.yml \
    --ask-become-pass \
    --ask-vault-pass \
    --user $(whoami) \
    --tags core,ssh,dotfiles,neovim

# testing ssh docker
ansible-playbook init.yml -i inventory/test.yml \
    --ask-become-pass \
    --skip-tags dev,local,localhost --limit=test

```

## Test

```shell
docker build . -t setup-ubuntu
docker run -it -v "$PWD:/home/$(whoami)/$(basename $PWD)" --rm setup-ubuntu
```
