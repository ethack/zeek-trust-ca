#!/bin/bash

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null

FILENAME=__load__.zeek

echo "redef SSL::root_certs += {" >"$FILENAME"

# Prevent * from printing an error if there are no matches
shopt -s nullglob
for f in *.cer *.crt *.pem *.der; do
    echo "Processing $f"
    echo -n "    [\"${f%.*}\"] = \"" >>"$FILENAME"
    # handle base64 PEM
    if grep -qF 'BEGIN CERTIFICATE-----' "$f"; then
        openssl x509 -in "$f" -inform PEM -outform DER | hexdump -v -e '1/1 "\\\x"' -e '1/1 "%02X"' >>"$FILENAME"
    else # handle binary DER
        hexdump -v -e '1/1 "\\\x"' -e '1/1 "%02X"' "$f" >>"$FILENAME"
    fi
    echo '",' >>"$FILENAME"
done

echo "};" >>"$FILENAME"

popd >/dev/null
