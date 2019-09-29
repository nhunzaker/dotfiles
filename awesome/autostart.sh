#!/usr/bin/env bash

# This script runs with every restart of AwesomeWM.
# If you would like to run a command *once* on login,
# you can use ~/.xprofile

function run {
  if ! pgrep $1 > /dev/null ;
  then
    $@&
  fi
}

wal-colors

emacs-daemon

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
