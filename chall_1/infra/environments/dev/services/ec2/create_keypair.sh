#!/bin/bash

random_name() {
	local size="${1:-20}"
	tr -dc A-Za-z0-9 </dev/urandom | head -c "$size"
}


if [[ -p /dev/stdin ]]; then
	terraform_query="$(cat | jq -r '.name // ""')"
else
	terraform_query=""
fi

if [[ -z "$terraform_query" ]]; then
	key_name="${1:-$(random_name 10)}"
else
	key_name="$terraform_query.key"
fi

readonly key_name

# Check if keys already exist
if [[ -f "$key_name" || -f "$key_name.pub" ]]; then
	printf "Error: Key already exists. Check what happened.\n" >&2
	exit 1
fi

# Create key pair
readonly TEMP_DIR=$(mktemp -d)
readonly KEY_FULL_PATH="$TEMP_DIR/$key_name"
ssh-keygen -t rsa -N "" -f "$KEY_FULL_PATH" -q

# Check if keys were created
if [[ ! -f "$KEY_FULL_PATH" || ! -f "$KEY_FULL_PATH.pub" ]]; then
    printf "Error: Key files weren't created. Please review to investigate its errors.\n" >&2
    exit 1
fi

printf '{ "public": "%s.pub", "private": "%s" }' "$KEY_FULL_PATH" "$KEY_FULL_PATH"
exit 0