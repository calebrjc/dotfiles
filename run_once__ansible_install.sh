#!/bin/bash

sh ~/.local/bin/install-ansible.sh
ansible-playbook ~/.setup/setup.yml --ask-become-pass