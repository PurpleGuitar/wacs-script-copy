#!/bin/bash

#
# Validate input file
#
if [ -z "${1}" ]; then
    echo "Usage: ${0} input_filename"
    echo "Reads input file containing repo URLs and copies them to WACS/Staging"
    exit 1
fi
INPUT_FILE=${1}
if [ ! -f "${INPUT_FILE}" ]; then
    echo "ERROR: input file doesn't exist: ${INPUT_FILE}"
    exit 1
fi

#
# Make sure environment variables are set
#
REQUIRED_ENV_VARS=(GITEA_API_TOKEN GITEA_URL GITEA_USER)
for env_var in ${REQUIRED_ENV_VARS[@]}; do
    if [ -z "${!env_var}" ]; then
        echo "ERROR: Missing require env var: ${env_var}"
        exit 1
    fi
done

#
# Make sure gitea-cli exists
#
if ! command -v gitea &> /dev/null
then
    echo "ERROR: gitea binary not found in path."
    echo "Download from https://github.com/bashup/gitea-cli"
    exit 1
fi
