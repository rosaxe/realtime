# SPDX-License-Identifier: GPL-2.0-only

define Device/cameo-fw
  CAMEO_BOARD_MODEL = $$(DEVICE_MODEL)
  KERNEL := \
	kernel-bin | \
	append-dtb | \
	libdeflate-gzip | \
	uImage gzip | \
	cameo-tag
  IMAGES += factory_image1.bin
  IMAGE/factory_image1.bin := \
	append-kernel | \
	pad-to 64k | \
	append-rootfs | \
	pad-rootfs | \
	pad-to 16 | \
	check-size | \
	cameo-version | \
	cameo-headers
endef

define Device/d-link_dgs-1210
  $(Device/cameo-fw)
  IMAGE_SIZE := 13824k
  DEVICE_VENDOR := D-Link
  CAMEO_KERNEL_PART_SIZE := 1572864
  CAMEO_KERNEL_PART := 2
  CAMEO_ROOTFS_PART := 3
  CAMEO_CUSTOMER_SIGNATURE := 2
  CAMEO_BOARD_VERSION := 32
endef

# The "IMG-" uImage name allows flashing the iniramfs from the vendor Web UI.
# Avoided for sysupgrade, as the vendor FW would do an incomplete flash.
define Device/engenius_ews2910p
  IMAGE_SIZE := 8192k
  DEVICE_VENDOR := EnGenius
  DEVICE_PACKAGES += realtek-poe
  KERNEL_INITRAMFS := \
	kernel-bin | \
	append-dtb | \
	libdeflate-gzip | \
	uImage gzip -n 'IMG-0.00.00-c0.0.00'
endef

define Device/hpe_1920
  DEVICE_VENDOR := HPE
  IMAGE_SIZE := 29632k
  BLOCKSIZE := 64k
  H3C_PRODUCT_ID := 0x3c010501
  KERNEL := \
	kernel-bin | \
	append-dtb | \
	7z | \
	h3c-image | \
	h3c-vfs
  KERNEL_INITRAMFS := \
	kernel-bin | \
	append-dtb | \
	7z | \
	h3c-image
  IMAGE/sysupgrade.bin := \
	append-kernel | \
	pad-to $$$$(BLOCKSIZE) | \
	append-rootfs | \
	pad-rootfs | \
	check-size | \
	append-metadata
endef

define Device/zyxel_gs1900
  DEVICE_VENDOR := Zyxel
  IMAGE_SIZE := 6976k
  UIMAGE_MAGIC := 0x83800000
  KERNEL_INITRAMFS := \
	kernel-bin | \
	append-dtb | \
	libdeflate-gzip | \
	zyxel-vers | \
	uImage gzip
endef
