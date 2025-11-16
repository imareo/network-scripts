#!/bin/bash

# script to generate a predictable Locally Administered MAC address for a host name.

if [ -z "$1" ]; then
    echo "Usage: $0 <NAME>"
    exit 1
fi

INPUT_NAME="$1"

# get hash and take the first 5 bytes (10 hex characters) + 2 extra characters because of 02
HASH=$(echo -n "$INPUT_NAME" | sha256sum | cut -c1-12)

# set the Locally Administered Address (LAA) bit.
FIRST_OCTET="02"

MAC_ADDRESS="$FIRST_OCTET:${HASH:0:2}:${HASH:2:2}:${HASH:4:2}:${HASH:6:2}:${HASH:8:2}"

MAC_ADDRESS_LOWER=$(echo "$MAC_ADDRESS" | tr '[:upper:]' '[:lower:]')

# Output the result message in English
echo "Generated MAC Address for '$INPUT_NAME': $MAC_ADDRESS_LOWER"