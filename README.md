A BuildRoot overlay for testing `linux-integrity` kernel patches, and patches going
to [linux-tpmdd](https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git)
in particular. Builds [swtpm](https://github.com/stefanberger/swtpm) for the host and
hosts it as a TPM emulator for QEMU.

## Build

Basic build process is:

```
git clone https://github.com/jarkkojs/tpmdd-buildroot-external
cd tpmdd-buildroot-external
make
```

This makes a build for `tpmdd_qemu_x86_64` board, which is the only board defined
at the moment. More boards, including real hardware targets are planned to be
added in future.

## Configuration

Configuring BuildRoot:

```
make buildroot-menuconfig
```

Configuring Linux kernel:

```
make linux-menuconfig
```

## TPM emulation

1. TPM2 TIS/FIFO: `output/build/images/start-qemu.sh`
2. TPM2 TIS/CRB: `output/build/images/start-qemu.sh --tpm-crb`
3. TPM1 TIS/FIFO: `output/build/images/start-qemu.sh --tpm1`

## kselftest


```
/usr/lib/kselftests/run_selftest.sh
```

## SSH


```
ssh -F output/build/images/ssh_config tpmdd.local
```
