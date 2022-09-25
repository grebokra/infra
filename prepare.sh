#!/bin/sh -eu
if ! which ansible-playbook 2>/dev/null 1>&2; then
    echo 'You have to have ansible installed!' 1>&2
    echo 'Please make sure it is available in $PATH' 1>&2
    exit 1
fi

# install required roles from the internet
ansible-galaxy role install -r requirements.yml -p roles/

# fetch inventory from another place
if ! stat inventory 2>/dev/null 1>&2; then
    if ping -c1 gitea.c2.int.nyansq.ru 2>/dev/null 1>&2; then
        git clone git@gitea.c2.int.nyansq.ru:gmelnikov/infra-inventory.git inventory --depth=1
    else
        cp -r inventory.example inventory
    fi
fi
