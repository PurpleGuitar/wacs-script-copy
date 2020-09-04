#!/bin/bash

# Make sure file was given
if [ -z "${1}" ]; then
    echo "Usage: ${0} input_filename"
    echo "Reads input file containing repo URLs and copies them to WACS/Staging"
    exit 1
fi

# Make sure environment variables are set
REQUIRED_ENV_VARS=(GITEA_API_TOKEN GITEA_URL GITEA_USER)
for env_var in ${REQUIRED_ENV_VARS[@]}; do
    if [ -z "${!env_var}" ]; then
        echo "ERROR: Missing require env var: ${env_var}"
        exit 1
    fi
done

