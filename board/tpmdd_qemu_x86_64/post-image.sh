#!/bin/env bash

BOARD_DIR="$(dirname "$0")"

sed \
  -e "s|@HOST_DIR@|${HOST_DIR}|g" \
  <"${BOARD_DIR}/start-qemu.sh.in" \
  >"${BINARIES_DIR}/start-qemu.sh"

chmod +x "${BINARIES_DIR}/start-qemu.sh"
