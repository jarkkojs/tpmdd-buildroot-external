################################################################################
#
# swtpm
#
################################################################################

SWTPM_VERSION = v0.8.1
SWTPM_SOURCE = $(SWTPM_VERSION).tar.gz
SWTPM_SITE = $(call github,stefanberger,swtpm,$(SWTPM_VERSION))
SWTPM_LICENSE = BSD-3-Clause
SWTPM_AUTORECONF = YES

HOST_SWTPM_DEPENDENCIES = host-libtasn1 host-openssl host-pkgconf host-json-glib host-libtpms
HOST_SWTPM_CONF_ENV = PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)"
HOST_SWTPM_CONF_OPTS = --without-seccomp

$(eval $(host-autotools-package))
