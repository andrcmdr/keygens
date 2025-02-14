#!/bin/bash
#/usr/bin/env bash

rename -v -n 's/\.pubkey\.pem$/\.key\.pem\.pub/' *.pubkey.pem
rename -v 's/\.pubkey\.pem$/\.key\.pem\.pub/' *.pubkey.pem

rename -v -n 's/\.pubkey\.ssh$/\.key\.ssh\.pub/' *.pubkey.ssh
rename -v 's/\.pubkey\.ssh$/\.key\.ssh\.pub/' *.pubkey.ssh

