#!/bin/env bash

QEMU_BOARD_DIR="$(dirname "$0")"

cp "${QEMU_BOARD_DIR}/start-qemu.sh.in" "${BINARIES_DIR}/start-qemu.sh"
chmod +x "${BINARIES_DIR}/start-qemu.sh"
