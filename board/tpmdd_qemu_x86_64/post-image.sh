#!/bin/env bash

BOARD_DIR="$(dirname "$0")"

function install_script {
  sed \
    -e "s|@HOST_DIR@|${HOST_DIR}|g" \
    <"${BOARD_DIR}/$1.in" \
    >"${BINARIES_DIR}/$1"
  chmod +x "${BINARIES_DIR}/$1"
}

install_script start-qemu.sh
install_script run-kselftest-tpm2.sh
install_script kselftest-tpm2.exp
