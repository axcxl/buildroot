################################################################################
#
# openocd
#
################################################################################

OPENOCD_SITE = https://git.code.sf.net/p/openocd/code
OPENOCD_VERSION = 21b9a0e1
OPENOCD_SITE_METHOD = git
OPENOCD_GIT_SUBMODULES = YES
OPENOCD_LICENSE = GPL-2.0+
OPENOCD_LICENSE_FILES = COPYING
OPENOCD_AUTORECONF = YES
OPENOCD_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -std=gnu99"

OPENOCD_CONF_OPTS = \
	--oldincludedir=$(STAGING_DIR)/usr/include \
	--includedir=$(STAGING_DIR)/usr/include \
	--disable-doxygen-html \
	--disable-internal-jimtcl \
	--disable-shared \
	--enable-dummy \
	--disable-werror

# Rely on the Config.in options of each individual adapter selecting
# the dependencies they need.

OPENOCD_DEPENDENCIES = \
	host-pkgconf \
	jimtcl \
	$(if $(BR2_PACKAGE_LIBFTDI1),libftdi1) \
	$(if $(BR2_PACKAGE_LIBUSB),libusb) \
	$(if $(BR2_PACKAGE_LIBUSB_COMPAT),libusb-compat) \
	$(if $(BR2_PACKAGE_LIBHID),libhid) \
	$(if $(BR2_PACKAGE_HIDAPI),hidapi)

# Adapters
OPENOCD_CONF_OPTS += \
	$(if $(BR2_PACKAGE_OPENOCD_FTDI),--enable-ftdi,--disable-ftdi) \
	$(if $(BR2_PACKAGE_OPENOCD_STLINK),--enable-stlink,--disable-stlink) \
	$(if $(BR2_PACKAGE_OPENOCD_TI_ICDI),--enable-ti-icdi,--disable-ti-icdi) \
	$(if $(BR2_PACKAGE_OPENOCD_ULINK),--enable-ulink,--disable-ulink) \
	$(if $(BR2_PACKAGE_OPENOCD_UBLASTER2),--enable-usb-blaster-2,--disable-usb-blaster-2) \
	$(if $(BR2_PACKAGE_OPENOCD_JLINK),--enable-jlink,--disable-jlink) \
	$(if $(BR2_PACKAGE_OPENOCD_OSDBM),--enable-osbdm,--disable-osbdm) \
	$(if $(BR2_PACKAGE_OPENOCD_OPENDOUS),--enable-opendous,--disable-opendous) \
	$(if $(BR2_PACKAGE_OPENOCD_AICE),--enable-aice,--disable-aice) \
	$(if $(BR2_PACKAGE_OPENOCD_VSLLINK),--enable-vsllink,--disable-vsllink) \
	$(if $(BR2_PACKAGE_OPENOCD_USBPROG),--enable-usbprog,--disable-usbprog) \
	$(if $(BR2_PACKAGE_OPENOCD_RLINK),--enable-rlink,--disable-rlink) \
	$(if $(BR2_PACKAGE_OPENOCD_ARMEW),--enable-armjtagew,--disable-armjtagew) \
	$(if $(BR2_PACKAGE_OPENOCD_CMSIS_DAP),--enable-cmsis-dap,--disable-cmsis-dap) \
	$(if $(BR2_PACKAGE_OPENOCD_PARPORT),--enable-parport,--disable-parport) \
	$(if $(BR2_PACKAGE_OPENOCD_VPI),--enable-jtag_vpi,--disable-jtag_vpi) \
	$(if $(BR2_PACKAGE_OPENOCD_UBLASTER),--enable-usb-blaster,--disable-usb-blaster) \
	$(if $(BR2_PACKAGE_OPENOCD_AMTJT),--enable-amtjtagaccel,--disable-amjtagaccel) \
	$(if $(BR2_PACKAGE_OPENOCD_ZY1000_MASTER),--enable-zy1000-master,--disable-zy1000-master) \
	$(if $(BR2_PACKAGE_OPENOCD_ZY1000),--enable-zy1000,--disable-zy1000) \
	$(if $(BR2_PACKAGE_OPENOCD_EP93XX),--enable-ep93xx,--disable-ep93xx) \
	$(if $(BR2_PACKAGE_OPENOCD_AT91RM),--enable-at91rm9200,--disable-at91rm9200) \
	$(if $(BR2_PACKAGE_OPENOCD_BCM2835),--enable-bcm2835gpio,--disable-bcm2835gpio) \
	$(if $(BR2_PACKAGE_OPENOCD_GW16012),--enable-gw16012,--disable-gw16012) \
	$(if $(BR2_PACKAGE_OPENOCD_PRESTO),--enable-presto,--disable-presto) \
	$(if $(BR2_PACKAGE_OPENOCD_OPENJTAG),--enable-openjtag,--disable-openjtag) \
	$(if $(BR2_PACKAGE_OPENOCD_BUSPIRATE),--enable-buspirate,--disable-buspirate) \
	$(if $(BR2_PACKAGE_OPENOCD_SYSFS),--enable-sysfsgpio,--disable-sysfsgpio)

# Enable all configuration options for host build.
#
# Note that deprecated options have been removed. CMSIS_DAP needs
# hidapi (currently not included in buildroot) and zy1000 stuff fails
# to build, so they've been removed too.
#
HOST_OPENOCD_CONF_OPTS = \
	--enable-ftdi \
	--enable-stlink \
	--enable-ti-icdi \
	--enable-ulink \
	--enable-usb-blaster-2 \
	--enable-jlink \
	--enable-osbdm \
	--enable-opendous \
	--enable-aice \
	--enable-vsllink \
	--enable-usbprog \
	--enable-rlink \
	--enable-armjtagew \
	--enable-parport \
	--enable-jtag_vpi \
	--enable-usb-blaster \
	--enable-amtjtagaccel \
	--enable-gw16012 \
	--enable-presto \
	--enable-openjtag \
	--enable-buspirate \
	--enable-sysfsgpio \
	--oldincludedir=$(HOST_DIR)/include \
	--includedir=$(HOST_DIR)/include \
	--disable-doxygen-html \
	--disable-internal-jimtcl \
	--disable-shared \
	--enable-dummy \
	--disable-werror

HOST_OPENOCD_DEPENDENCIES = host-jimtcl host-libftdi host-libusb host-libusb-compat

$(eval $(autotools-package))
$(eval $(host-autotools-package))
