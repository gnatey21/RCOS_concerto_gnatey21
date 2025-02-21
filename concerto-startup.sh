#!/bin/bash
# This is the concerto startup script
current_ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
cd ~/concerto

RAILS_ENV=development bundle exec rails server -b $current_ip &

sleep 8

chromium --start-fullscreen --kiosk $current_ip:3000/frontend/3 &