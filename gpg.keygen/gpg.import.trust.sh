#!/bin/bash
#/usr/bin/env bash

shopt -s extglob
shopt -s extquote
# shopt -s xpg_echo

set -f

declare file_def='./private.key'
declare GNUPGHOME=${GNUPGHOME:-"$HOME/.gnupg/"}

echo -e "$GNUPGHOME"

declare file=${1:-$file_def}
declare home_dir=${2:-"$GNUPGHOME"}

if [[ "$(echo "${home_dir}" | sed -r "s/\/home\/.+\/.gnupg(\/)?/OK/gI")" == "OK" ]]; then
    declare keyring="--primary-keyring ${home_dir}/pubring.gpg"
else
    declare keyring="--keyring ${home_dir}/keyring.gpg"
fi

killall -v -9 gpg-agent

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --trustdb-name ${home_dir}/trustdb.gpg ${keyring} --secret-keyring ${home_dir}/secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint | grep -iPn --color "((?<=0x)([a-fA-F0-9]{16})(?=\s))?"

gpg --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ${home_dir} --trustdb-name ${home_dir}/trustdb.gpg ${keyring} --secret-keyring ${home_dir}/secring.gpg --pinentry-mode 'loopback' --import-options 'keep-ownertrust' --import "${file}"

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --trustdb-name ${home_dir}/trustdb.gpg ${keyring} --secret-keyring ${home_dir}/secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint | grep -iPn --color "((?<=0x)([a-fA-F0-9]{16})(?=\s))?"

{
    echo "uid *"
    echo "key *"
    echo "trust"
    echo 5
    echo y
    echo "save"
# } | gpg --command-fd 0 --status-fd 1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ${home_dir} --trustdb-name ${home_dir}/trustdb.gpg ${keyring} --secret-keyring ${home_dir}/secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --pinentry-mode 'loopback' --edit-key "${name} (GNUPG keys for ${resource}) <${email}>"
} | gpg --command-fd 0 --status-fd 1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ${home_dir} --trustdb-name ${home_dir}/trustdb.gpg ${keyring} --secret-keyring ${home_dir}/secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --pinentry-mode 'loopback' --edit-key "$(echo -E "${file}" | grep -iPo "([a-fA-F0-9]{16})")"

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ${home_dir} --trustdb-name ${home_dir}/trustdb.gpg ${keyring} --secret-keyring ${home_dir}/secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint | grep -iPn --color "((?<=0x)([a-fA-F0-9]{16})(?=\s))?"

gpg --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ${home_dir} --trustdb-name ${home_dir}/trustdb.gpg ${keyring} --secret-keyring ${home_dir}/secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --pinentry-mode 'loopback' --export-ownertrust > "${home_dir}/ownertrust.db"

# gpg -n --import --import-options import-show F855DCF2A03623C1!.private.key

