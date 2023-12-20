A BuildRoot overlay for testing `linux-integrity` kernel patches, and patches going
to [linux-tpmdd](https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git)
in particular. Uses [swtpm](https://github.com/stefanberger/swtpm) as a TPM emulation
layer for QEMU.

## Build

The basic build process is:

```
git clone https://github.com/jarkkojs/tpmdd-buildroot-external
cd tpmdd-buildroot-external
make
```

This makes a build for `tpmdd_qemu_x86_64` board, which is the only board defined
at the moment.

## Configuration

Configuring BuildRoot:

```
make buildroot-menuconfig
```

Configuring Linux kernel:

```
make linux-menuconfig
```

## Running QEMU

Starting QEMU process:

1. TPM2 TIS/FIFO: `output/images/start-qemu.sh &`
2. TPM2 TIS/CRB: `output/images/start-qemu.sh --tpm-crb &`
3. TPM1 TIS/FIFO: `output/images/start-qemu.sh --tpm1 &`

Serial console access:

```
socat - UNIX-CONNECT:output/images/serial.sock
```

QEMU monitor access:

```
socat - UNIX-CONNECT:output/images/monitor.sock
```

Ending QEMU process:

```
kill -15 `cat output/images/qemu.pid`
```

## SSH

```
ssh -F output/build/images/ssh_config tpmdd.local
```

## kselftest

The image has `kselftest` pre-installed. TPM2 tests can be run by:

```
/usr/lib/kselftests/run_kselftest.sh -t tpm2:test_smoke.sh
/usr/lib/kselftests/run_kselftest.sh -t tpm2:test_space.sh
/usr/lib/kselftests/run_kselftest.sh -t tpm2:test_async.sh
```
