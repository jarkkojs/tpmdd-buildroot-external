# SPDX-License-Identifier: MIT

ROOT			:= $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
OUTPUT			:= $(ROOT)output
PATCHES			:= $(ROOT)patches

BUILDROOT_VERSION	:= 2023.11
BUILDROOT_SITE		:= https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.gz

define buildroot
	make -C "$(OUTPUT)/buildroot" \
		BR2_EXTERNAL="$(ROOT)" \
		O="$(OUTPUT)/build" $(1)
endef

all: buildroot

.PHONY: buildroot
buildroot: prepare
	$(call buildroot,all)

.PHONY: buildroot-menuconfig
buildroot-menuconfig: prepare
	$(call buildroot,menuconfig)
	$(call buildroot,savedefconfig)

.PHONY: linux-menuconfig
linux-menuconfig: prepare
	$(call buildroot,linux-menuconfig)
	$(call buildroot,linux-update-defconfig)

.PHONY: prepare
prepare: $(OUTPUT)/buildroot-stamp

$(OUTPUT)/buildroot-stamp:
	rm -rf "$(OUTPUT)/buildroot"
	mkdir -p "$(OUTPUT)/buildroot"
	curl -sL "$(BUILDROOT_SITE)" | tar -zxv -C "$(OUTPUT)/buildroot" --strip-components=1
	cd "$(OUTPUT)/buildroot" && patch -p1 < "$(PATCHES)/buildroot/0001-json-glib-host.patch"
	$(call buildroot,tpmdd_qemu_x86_64_defconfig)
	touch $@

.PHONY: clean
clean:
	rm -rf "$(OUTPUT)"
