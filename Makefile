# SPDX-License-Identifier: MIT

ROOT			:= $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
BUILDROOT_VERSION	:= 2023.11
OUTPUT			:= $(ROOT)output
PATCHES			:= $(ROOT)patches
BUILDROOT_URL		:= https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.gz

define make-buildroot
	make -C "$(OUTPUT)/buildroot" BR2_EXTERNAL="$(ROOT)" O="$(OUTPUT)/build" $(1)
endef

define patch-buildroot
	cd "$(OUTPUT)/buildroot" && patch -p1 < "$(PATCHES)/buildroot/$(1)"
endef

define download-package
	mkdir -p $(2)
	curl -sL "$(1)" | tar -zxv -C "$(2)" --strip-components=1
endef

all: buildroot

.PHONY: buildroot
buildroot: prepare
	$(call make-buildroot,tpmdd_qemu_x86_64_defconfig)
	$(call make-buildroot,all)

.PHONY: buildroot-menuconfig
buildroot-menuconfig: prepare
	$(call make-buildroot,tpmdd_qemu_x86_64_defconfig)
	$(call make-buildroot,menuconfig)
	$(call make-buildroot,savedefconfig)

.PHONY: linux-menuconfig
linux-menuconfig: prepare
	$(call make-buildroot,tpmdd_qemu_x86_64_defconfig)
	$(call make-buildroot,linux-menuconfig)
	$(call make-buildroot,linux-savedefconfig)

.PHONY: prepare
prepare: $(OUTPUT)/buildroot-stamp

$(OUTPUT)/buildroot-stamp:
	$(call download-package,"$(BUILDROOT_URL)","$(OUTPUT)/buildroot")
	$(call patch-buildroot,0001-json-glib-host.patch)
	touch $@

.PHONY: clean
clean:
	rm -rf "$(OUTPUT)"
