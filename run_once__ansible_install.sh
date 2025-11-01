#!/bin/bash

sh ~/.local/bin/install-prg-ansible.sh
ansible-playbook ~/.setup/setup.yml --ask-become-pass