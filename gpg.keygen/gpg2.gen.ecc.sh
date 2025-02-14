#!/bin/bash
#/usr/bin/env bash

shopt -s extglob
shopt -s extquote
# shopt -s xpg_echo

set -f

declare -rx pwd_def='{{PASSWORD}}' # JUST ENTER PASSWORD FOR GPG KEY PAIR GENERATION HERE
declare -rx email_def='commandr@commandr.stream' '{{E-MAIL}}' # EMAIL FOR GPG KEY FILE COMMENT
declare -rx resource_def='KeyBase' '{{RESOURCE_NAME}}' # RESOURCE NAME FOR GPG KEY FILE COMMENT, i.e. 'github', 'gitlab', 'bitbucket', 'aws', 'gcp', 'azure', 'digital-ocean', 'hetzner-cloud', 'contabo', 'genesis', etc.
declare -rx name_def='Andrew Bednoff' '{{USER_NAME}}' # GPG KEY OWNER/USER NAME FOR GPG KEY FILE COMMENT
declare -rx date_from_def='1989-02-02' '{{CREATION_DATE}}' # GPG KEY CREATION DATE/TIME

declare -rx pwd=${1:-$pwd_def}
declare -rx email=${2:-$email_def}
declare -rx resource=${3:-$resource_def}
declare -rx name=${4:-$name_def}
declare -rx date_from=${5:-$date_from_def}

echo -e ""
echo -E "${pwd}"
echo -e ""

declare -xgi iter=0
declare -xg tag=""
declare -xg main_hash="0x"

function hash_evaluation () {
    local -n iter_ref=$2
    local -n main_hash_ref=$3

#    for hash in ${2}; do
    for hash in ${1}; do

        iter_ref+=1

        if [[ iter -eq 1 ]]; then
            tag='!'
            main_hash_ref="${hash}"
        else
            tag=''
        fi

        echo -E "${hash}"

        {
            echo "uid *"
            echo "key *"
            echo "trust"
            echo 5
            echo y
#            echo "passwd"
            echo "save"
        } | gpg --command-fd 0 --status-fd 1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --edit-key "${hash}"

        gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --armor --output ./${hash}${tag:+"${tag}"}.public.key --export ${hash}

        gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --armor --output ./${hash}${tag:+"${tag}"}.private.key --export-secret-keys ${hash}

        gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --armor --output ./${hash}${tag:+"${tag}"}.private.sub.key --export-secret-subkeys ${hash}

        gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --armor --output ./${hash}${tag:+"${tag}"}.ssh.key --export-ssh-key ${hash}

        sed -r -s -i"" "s/openpgp:.*$/${email}:0x${hash}${tag:+"${tag}"}/gI" ./${hash}${tag:+"${tag}"}.ssh.key

        echo -e "\n    ${hash}${tag:+"${tag}"}.public.key:\n" >> ./dump.key
        pgpdump ./${hash}${tag:+"${tag}"}.public.key >> ./dump.key

        echo -e "\n    ${hash}${tag:+"${tag}"}.private.key:\n" >> ./dump.key
        pgpdump ./${hash}${tag:+"${tag}"}.private.key >> ./dump.key

        echo -e "\n    ${hash}${tag:+"${tag}"}.private.sub.key:\n" >> ./dump.key
        pgpdump ./${hash}${tag:+"${tag}"}.private.sub.key >> ./dump.key

#        cat ./dump.key | grep -iP --color "(alg|bit)?"

        {
            echo y
            echo 0
            echo
            echo y
        } | gpg --command-fd 0 --status-fd 1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --armor --output ./${hash}${tag:+"${tag}"}.rev.key --gen-revoke ${hash}

    done
}

tee ./gnupg.conf << conf
keyid-format 0xlong
fingerprint
with-fingerprint
with-subkey-fingerprint

# pinentry-mode loopback

enable-large-rsa
enable-dsa2

disable-pubkey-algo ELG ELG-E DSA
disable-cipher-algo AES192 CAMELLIA192 AES AES128 CAMELLIA128 BLOWFISH CAST5 3DES IDEA

weak-digest MD5
weak-digest SHA1
weak-digest RIPEMD160
weak-digest SHA224
weak-digest SHA256
weak-digest SHA384

default-preference-list SHA512 AES256 CAMELLIA256 TWOFISH BZIP2 ZIP

# default-new-key-algo RSA4096
# default-new-key-algo "rsa4096/encr,sign,auth,cert+rsa4096/encr,sign,auth,cert"
# default-new-key-algo "ed25519/sign,auth,cert+cv25519/encr"

personal-digest-preferences SHA512
personal-cipher-preferences AES256 CAMELLIA256 TWOFISH
personal-compress-preferences BZIP2 ZIP

s2k-digest-algo SHA512
s2k-cipher-algo AES256
s2k-mode 3
s2k-count 65011712

digest-algo SHA512
cert-digest-algo SHA512
cipher-algo AES256
compress-algo BZIP2

bzip2-compress-level 9
compress-level 9

conf

tee ./unattend.settings.conf << conf
%echo Generating GNUPG (OpenPGP) keys
# %dry-run

%pubring ./keyring.gpg
%secring ./secring.gpg

Key-Type: EDDSA
# Key-Curve: ed25519
Key-Curve: Ed25519
Key-Length: 4096
Key-Usage: sign,auth,cert
# Key-Usage: encrypt,sign,auth,cert
Subkey-Type: ECDH
# Subkey-Curve: cv25519
Subkey-Curve: Curve25519
Subkey-Length: 4096
Subkey-Usage: encrypt
# Subkey-Usage: encrypt,sign,auth,cert
Passphrase: ${pwd}
Name-Real: ${name}
Name-Comment: GNUPG keys for ${resource}
Name-Email: ${email}
Expire-Date: 0
Creation-Date: ${date_from}
Preferences: SHA512 AES256 ZLIB

%commit
%echo Done!

conf

killall -v -9 gpg-agent

gpg-agent --s2k-calibration 5000 --s2k-count 65011712

gpg --verbose --no-use-agent --expert --gnupg --options ./gnupg.conf --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --batch --disable-pubkey-algo 'ELG ELG-E DSA' --disable-cipher-algo 'AES192 CAMELLIA192 AES AES128 CAMELLIA128 BLOWFISH CAST5 3DES IDEA' --weak-digest 'MD5' --weak-digest 'SHA1' --weak-digest 'RIPEMD160' --weak-digest 'SHA224' --weak-digest 'SHA256' --weak-digest 'SHA384' --default-preference-list 'SHA512 AES256 CAMELLIA256 TWOFISH BZIP2 ZIP' --enable-dsa2 --enable-large-rsa --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --personal-digest-preferences 'SHA512' --personal-cipher-preferences 'AES256 CAMELLIA256 TWOFISH' --personal-compress-preferences 'BZIP2 ZIP' --digest-algo 'SHA512' --cert-digest-algo 'SHA512' --cipher-algo 'AES256' --compress-algo 'BZIP2' --bzip2-compress-level '9' --compress-level '9' --passphrase '${pwd}' --comment 'GNUPG keys for ${resource}' --full-generate-key ./unattend.settings.conf

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint | grep -iPn --color "((?<=0x)([a-fA-F0-9]{16})(?=\s))?"

# gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint 2>/dev/null | grep -iPo "((?<=0x)([a-fA-F0-9]{16})(?=\s))" | readarray -d "" -t -n 0 -O 0 -C hash_evaluation -c 1 -u 0 inputval < /dev/stdin
hash_evaluation "$(gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint 2>/dev/null | grep -iPo "((?<=0x)([a-fA-F0-9]{16})(?=\s))")" iter main_hash

# {
#     echo "uid *"
#     echo "key *"
#     echo "trust"
#     echo 5
#     echo y
#     echo "save"
# } | gpg --command-fd 0 --status-fd 1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --edit-key "${name} (GNUPG keys for ${resource}) <${email}>"
# } | gpg --command-fd 0 --status-fd 1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --edit-key "${main_hash}"

gpg --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --export-ownertrust > ./ownertrust.db

# gpg -n --import --import-options import-show F855DCF2A03623C1!.private.key

