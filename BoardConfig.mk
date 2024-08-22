#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/r5x

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a73

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a73

# Assert
TARGET_OTA_ASSERT_DEVICE := RMX1911,RMX1925,RMX1927,RMX2030,r5x,realme_trinket

# Audio
AUDIO_FEATURE_ENABLED_AAC_ADTS_OFFLOAD := true
AUDIO_FEATURE_ENABLED_AUDIOSPHERE := true
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true

# AVB (Android Verified Boot)
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := trinket
TARGET_NO_BOOTLOADER := true

# Build
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
BUILD_BROKEN_ENFORCE_SYSPROP_OWNER := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true

# Camera
TARGET_NEEDS_RAW10_BUFFER_FIX := true
TARGET_USES_QTI_CAMERA_DEVICE := true
USE_DEVICE_SPECIFIC_CAMERA := true

# Data Services
SOONG_CONFIG_NAMESPACES += rmnetctl
SOONG_CONFIG_rmnetctl += \
    old_rmnet_data

SOONG_CONFIG_rmnetctl_old_rmnet_data := true

# Display
TARGET_USES_ION := true
TARGET_SCREEN_DENSITY := 440

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
LOC_HIDL_VERSION := 4.0

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/configs/manifests/manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/configs/manifests/framework_compatibility_matrix.xml
ODM_MANIFEST_SKUS += nfc_ese
ODM_MANIFEST_NFC_ESE_FILES := $(DEVICE_PATH)/configs/manifests/manifest_nfc_ese.xml

# Init
TARGET_INIT_VENDOR_LIB := libinit_r5x
TARGET_RECOVERY_DEVICE_MODULES := libinit_r5x

# Kernel
BOARD_BOOT_HEADER_VERSION := 1
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_SOURCE := kernel/realme/r5x
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CONFIG := biofrost_defconfig

BOARD_KERNEL_CMDLINE := \
      console=ttyMSM0,115200n8 \
      androidboot.hardware=qcom \
      androidboot.console=ttyMSM0 \
      lpm_levels.sleep_disabled=1 \
      msm_rtb.filter=0x237 \
      service_locator.enable=1 \
      swiotlb=1 \
      earlycon=msm_geni_serial,0x4a90000 \
      loop.max_part=7 \
      cgroup.memory=nokmem,nosocket \
      androidboot.init_fatal_reboot_target=recovery \
      kpti=off \
      androidboot.boot_devices=soc/4744000.sdhci \
      androidboot.android_dt_dir=/non-existent \
      nosdcardfs

# Media
TARGET_DISABLED_UBWC := true

# NFC
TARGET_USES_NQ_NFC := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 402653184
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_SYSTEMIMAGE_PARTITION_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_EROFS_PCLUSTER_SIZE := 262144
BOARD_EROFS_COMPRESSOR := lz4
PRODUCT_FS_COMPRESSION := 1

BOARD_SUPER_PARTITION_BLOCK_DEVICES := vendor system
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE := 1452277760
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 5114429440
BOARD_SUPER_PARTITION_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE) + $(BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE) )

BOARD_SUPER_PARTITION_GROUPS := r5x_dynpart
BOARD_R5X_DYNPART_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) - 4194304 )
BOARD_R5X_DYNPART_PARTITION_LIST := odm product system system_ext vendor

BOARD_ROOT_EXTRA_SYMLINKS := \
    /vendor/firmware_mnt:/firmware \
    /vendor/bt_firmware:/bt_firmware

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

BOARD_USES_METADATA_PARTITION := true

# Platform
TARGET_BOARD_PLATFORM := trinket

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/props/system.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/props/product.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/props/vendor.prop

# Power
TARGET_TAP_TO_WAKE_NODE := "/proc/touchpanel/double_tap_enable"
TARGET_POWERHAL_MODE_EXT := $(DEVICE_PATH)/power/power-mode.cpp
TARGET_USES_INTERACTION_BOOST := true

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

# Recovery
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Security patch level
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private
BOARD_SEPOLICY_M4DEFS += \
     sysfs_battery_supply=vendor_sysfs_battery_supply \
     sysfs_usb_supply=vendor_sysfs_usb_supply

# WiFi
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WIFI_DRIVER_DEFAULT := qca_cld3

# Inherit the proprietary files
include vendor/realme/r5x/BoardConfigVendor.mk
