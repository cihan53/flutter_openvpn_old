#!/usr/bin/env bash

source /app/vagrant/provision/common.sh

#== Provision script ==

info "Provision-script user: `whoami`"

info "Run Start vnc"
cd noVNC
sudo ./utils/launch.sh --vnc localhost:5901
