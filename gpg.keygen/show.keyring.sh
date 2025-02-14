#!/bin/bash
#/usr/bin/env bash

shopt -s extglob
shopt -s extquote
# shopt -s xpg_echo

set -f

declare GNUPGHOME=${GNUPGHOME:-"$HOME/.gnupg/"}

echo -e "$GNUPGHOME"

declare -g home_dir=${1:-"$GNUPGHOME"}
declare -g search_pattern=${2:-"((?<=0x)([a-fA-F0-9]{16})(?=\s))?"}

echo
if [[ "$(echo "${home_dir}" | sed -r "s/\/home\/.+\/.gnupg(\/)?/OK/gI")" == "OK" ]]; then
    gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --trustdb-name ${home_dir}/trustdb.gpg --primary-keyring ${home_dir}/pubring.gpg --secret-keyring ${home_dir}/secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint 2>/dev/null | grep -iP -C 2 --color "(${search_pattern})?" ;
else
    gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --trustdb-name ${home_dir}/trustdb.gpg --keyring ${home_dir}/keyring.gpg --secret-keyring ${home_dir}/secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint 2>/dev/null | grep -iP -C 2 --color "(${search_pattern})?" ;
fi
echo

# gpg1 --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint
# gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

# gpg1 --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --list-public-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint
# gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --list-public-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

# gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --list-secret-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

# gpg1 --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --list-sigs --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint
# gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --list-sigs --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

# gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --list-signatures --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

# gpg -n --import --import-options import-show F855DCF2A03623C1!.private.key

