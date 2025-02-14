#!/bin/bash
#/usr/bin/env bash

shopt -s extglob
shopt -s extquote
# shopt -s xpg_echo

set -f

declare -rx user_def='{{USER_NAME}}' # USER NAME FOR KEY FILE NAME
declare -rx resource_def='{{RESOURCE_NAME}}' # RESOURCE NAME FOR KEY FILE NAME, i.e. 'github', 'gitlab', 'bitbucket', 'aws', 'gcp', 'azure', 'digital-ocean', 'hetzner-cloud', 'contabo', 'genesis', etc.
declare -rx email_def='{{E-MAIL}}' # EMAIL FOR SSH KEY COMMENT
declare -rx pwd_def='{{PASSWORD}}' # JUST ENTER PASSWORD FOR KEY PAIR GENERATION HERE

declare -rx user=${1:-$user_def}
declare -rx resource=${2:-$resource_def}
declare -rx email=${3:-$email_def}
declare -rx pwd=${4:-$pwd_def}

echo -E "${pwd}"

# RSA, RSA-PSS
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -outform PEM -out ${user:+"${user}."}${resource:+"${resource}."}key.pem -aes-256-cbc -pass env:pwd

openssl pkey -in ${user:+"${user}."}${resource:+"${resource}."}key.pem -passin env:pwd -aes-256-cbc -passout env:pwd -outform PEM -pubout -out ${user:+"${user}."}${resource:+"${resource}."}key.pem.pub

openssl asn1parse -in ${user:+"${user}."}${resource:+"${resource}."}key.pem
echo -E "============"
openssl asn1parse -in ${user:+"${user}."}${resource:+"${resource}."}key.pem.pub

ssh-keygen -y -f ${user:+"${user}."}${resource:+"${resource}."}key.pem -P "${pwd}" -C "${email}" | sed -r -s "s/==.*$/== ${email}/gI" > ${user:+"${user}."}${resource:+"${resource}."}key.ssh.pub
# ssh-keygen -y -f ${user:+"${user}."}${resource:+"${resource}."}key.pem -P "${pwd}" -C "${email}" | sed -r -s "s/==.*$/== ${email}/gI" > ${user:+"${user}."}${resource:+"${resource}."}pubkey.ssh

# ssh-keygen -y -f ${user:+"${user}."}${resource:+"${resource}."}key.pem -P "${pwd}" -C "${email}" > ${user:+"${user}."}${resource:+"${resource}."}pubkey.ssh
# sed -r -s -i"" "s/==.*$/== ${email}/gI" ${user:+"${user}."}${resource:+"${resource}."}pubkey.ssh

# echo -ne " ${email}" | tee -a ${user:+"${user}."}${resource:+"${resource}."}pubkey.ssh

