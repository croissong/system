#!/bin/sh
VAULT_PW_FILENAME="vault"
gpgp --quiet --batch --use-agent --decrypt $VAULT_PW_FILENAME
