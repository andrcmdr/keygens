#!/bin/bash
#/usr/bin/env bash

shopt -s extglob
shopt -s extquote
# shopt -s xpg_echo

set -f

shred -v --force --iterations=1000 --random-source=/dev/random --remove=wipesync --zero -u ${@}

