################################################################################
#
# libtpms
#
################################################################################

LIBTPMS_VERSION = v0.9.6
LIBTPMS_SOURCE = $(LIBTPMS_VERSION).tar.gz
LIBTPMS_SITE = $(call github,stefanberger,libtpms,$(LIBTPMS_VERSION))
LIBTPMS_LICENSE = BSD-3-Clause
LIBTPMS_INSTALL_STAGING = YES
LIBTPMS_AUTORECONF = YES

$(eval $(autotools-package))
$(eval $(host-autotools-package))
