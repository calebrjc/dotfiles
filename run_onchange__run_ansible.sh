#!/bin/bash

if command -v ansible-playbook &> /dev/null; then
    ansible-playbook ~/.setup/setup.yml --ask-become-pass
end