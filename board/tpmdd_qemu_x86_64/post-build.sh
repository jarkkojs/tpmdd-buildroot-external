#!/usr/bin/env bash

set -u
set -e

BOARD_DIR="$(dirname "$0")"
IDENTITY_FILE="${TARGET_DIR}/root/.ssh/id_ed25519"

rm -rf "${TARGET_DIR}/root/.ssh"
mkdir -p "${TARGET_DIR}/root/.ssh"
ssh-keygen -C 'root@tpmdd.local' -t ed25519 -f "${TARGET_DIR}/root/.ssh/id_ed25519" -N ''
cp ${TARGET_DIR}/root/.ssh/id_ed25519.pub ${TARGET_DIR}/root/.ssh/authorized_keys

sed \
  -e "s|@IDENTITY_FILE@|${IDENTITY_FILE}|g" \
  <"${BOARD_DIR}/ssh_config.in" \
  >"${BINARIES_DIR}/ssh_config"
