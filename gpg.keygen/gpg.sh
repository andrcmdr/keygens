pwd
name
email
resource

--------------------------------------------------

killall -v -9 gpg-agent

gpg-agent --s2k-calibration 5000 --s2k-count 65011712

gpg1 --verbose --no-use-agent --expert --gnupg --options ./gnupg.conf --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --batch --pinentry-mode 'loopback' --disable-pubkey-algo 'ELG ELG-E DSA' --disable-cipher-algo 'AES192 CAMELLIA192 AES AES128 CAMELLIA128 BLOWFISH CAST5 3DES IDEA' --weak-digest 'MD5' --weak-digest 'SHA1' --weak-digest 'RIPEMD160' --weak-digest 'SHA224' --weak-digest 'SHA256' --weak-digest 'SHA384' --default-preference-list 'SHA512 AES256 CAMELLIA256 TWOFISH BZIP2 ZIP' --enable-dsa2 --enable-large-rsa --default-new-key-algo 'RSA4096' --s2k-digest-algo 'SHA512' --s2k-cipher-algo 'AES256' --s2k-mode '3' --s2k-count '65011712' --personal-digest-preferences 'SHA512' --personal-cipher-preferences 'AES256 CAMELLIA256 TWOFISH' --personal-compress-preferences 'BZIP2 ZIP' --digest-algo 'SHA512' --cert-digest-algo 'SHA512' --cipher-algo 'AES256' --compress-algo 'BZIP2' --bzip2-compress-level '9' --compress-level '9' --passphrase 'qcnkItU%R.?Yw62`d[~7' --comment 'GNUPG keys for KeyBase' --quick-generate-key 'Andy Francis (GNUPG keys for KeyBase) <commandr@commandr.stream>' rsa4096 encrypt,sign,auth,cert none

gpg1 --verbose --no-use-agent --expert --gnupg --options ./gnupg.conf --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --batch --pinentry-mode 'loopback' --passphrase 'qcnkItU%R.?Yw62`d[~7' --comment 'GNUPG keys for KeyBase' --quick-generate-key 'Andy Francis (GNUPG keys for KeyBase) <commandr@commandr.stream>' rsa4096 encrypt,sign,auth,cert none
gpg1 --verbose --no-use-agent --expert --gnupg --options ./gnupg.conf --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --batch --pinentry-mode 'loopback' --passphrase 'qcnkItU%R.?Yw62`d[~7' --comment 'GNUPG keys for KeyBase' --quick-gen-key 'Andy Francis (GNUPG keys for KeyBase) <commandr@commandr.stream>' rsa4096 encrypt,sign,auth,cert none

--quick-add-key fingerprint algo usage expire
--quick-add-key fingerprint rsa4096 encrypt,sign,auth,cert none

--default-new-key-algo "rsa4096/sign,auth,cert+rsa4096/encr"
--default-new-key-algo "ed25519/sign,auth,cert+cv25519/encr"

--gnupg
--openpgp
--rfc4880
--rfc4880bis
--rfc2440
--pgp6
--pgp7
--pgp8
--compliance gnupg

--no-keyring

--gen-key ./unattend.settings.conf

--generate-key ./unattend.settings.conf

--full-generate-key ./unattend.settings.conf

--homedir $GNUPGHOME --trustdb-name $GNUPGHOME/trustdb.gpg --primary-keyring $GNUPGHOME/keyring.gpg --secret-keyring $GNUPGHOME/secring.gpg

--------------------------------------------------

gpg --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --pinentry-mode 'loopback' --armor --output ./rev.key --generate-revocation keyID

gpg1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --pinentry-mode 'loopback' --armor --output ./rev.key --gen-revoke keyID

--------------------------------------------------

gpg1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --pinentry-mode 'loopback' --import-options 'keep-ownertrust' --import ./private.key

gpg1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --pinentry-mode 'loopback' --edit-key keyID | userID
uid index=1..
uid * // select all
uid 0 // deselect all
key index=1..
key * // select all
key 0 // deselect all
trust
save
revkey
revsig
revuid
save
quit

gpg1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --pinentry-mode 'loopback' --trusted-key keyID

--------------------------------------------------

gpg1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --pinentry-mode 'loopback' --export-ownertrust > ownertrust.db

gpg1 --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --pinentry-mode 'loopback' --import-ownertrust < ownertrust.db

--------------------------------------------------

gpg1 --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

gpg1 --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --list-public-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --list-secret-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

gpg1 --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --list-sigs --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --list-signatures --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

--------------------------------------------------

gpg1 --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --armor --output ./public.key --export CEADE89F4EF493DC

gpg1 --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --armor --output ./private.key --export-secret-keys CEADE89F4EF493DC

gpg1 --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --armor --output ./private.sub.key --export-secret-subkeys CEADE89F4EF493DC

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --armor --output ./ssh.key --export-ssh-key CEADE89F4EF493DC

--------------------------------------------------

pgpdump ./private.key | grep -iP --color "(alg|bit)?"
gpg1 --verbose --list-packets ./private.key | grep -iP --color "(alg|bit)?"
gpg1 -vv ./private.key | grep -iP --color "(alg|bit)?"

gpg -n --import --import-options import-show F855DCF2A03623C1!.private.key

--------------------------------------------------

openssl asn1parse -inform PEM -in ./key.pem

openssl x509 -inform PEM -text -noout -in ./cert.pem

openssl s_client -showcerts -state -connect commandr.stream:443
openssl s_client -showcerts -state -connect commandr.stream:443 -servername commandr.stream

--------------------------------------------------

gpg --verbose --default-key "3F14B3B74890C15F" --armor --sign ./text.txt
gpg --verbose --local-user "3F14B3B74890C15F" --armor --sign ./text.txt

gpg --verbose --default-key "3F14B3B74890C15F" --armor --clear-sign ./text.txt
gpg --verbose --local-user "3F14B3B74890C15F" --armor --clear-sign ./text.txt

gpg --verbose --default-key "3F14B3B74890C15F" --armor --detach-sign ./text.txt
gpg --verbose --local-user "3F14B3B74890C15F" --armor --detach-sign ./text.txt


gpg --verbose --default-key "AAF22D10BED9AACD" --verify ./text.txt.asc
gpg --verbose --default-key "AAF22D10BED9AACD" --verify ./text.txt.gpg
gpg --verbose --default-key "AAF22D10BED9AACD" --verify ./text.txt.sig

gpg --verbose --local-user "AAF22D10BED9AACD" --verify ./text.txt.asc
gpg --verbose --local-user "AAF22D10BED9AACD" --verify ./text.txt.gpg
gpg --verbose --local-user "AAF22D10BED9AACD" --verify ./text.txt.sig

--------------------------------------------------

gpg --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --pinentry-mode 'loopback' --import-options 'keep-ownertrust' --import "${file}"

gpg --verbose --no-use-agent --expert --gnupg --interactive --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --pinentry-mode 'loopback' --import-options 'keep-ownertrust' --keyserver pgp.mit.edu --recv-keys "8B48AD6246925553" "AED4B06F473041FA" "64481591B98321F9"

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --list-keys --keyid-format 0xlong --with-fingerprint --fingerprint --with-subkey-fingerprint

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --armor --output ./64481591B98321F9.key --export 64481591B98321F9

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --armor --output ./AED4B06F473041FA.key --export AED4B06F473041FA

gpg --verbose --no-use-agent --expert --no-default-keyring --homedir ./ --trustdb-name ./trustdb.gpg --keyring ./keyring.gpg --secret-keyring ./secring.gpg --armor --output ./8B48AD6246925553.key --export 8B48AD6246925553

