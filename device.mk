#
# Copyright (C) 2022-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

OVERRIDE_PRODUCT_COMPRESSED_APEX := false

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/egistec/fingerprint

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.0-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.soundtrigger@2.2-impl \
    android.hardware.audio.service \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libaudiopreprocessing \
    libhdmiedid \
    libhfp \
    libsndmonitor \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libvolumelistener \
    sound_trigger.primary.trinket

PRODUCT_PACKAGES += \
    libbatterylistener \
    libcomprcapture \
    libexthwplugin \
    libspkrprot

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

$(call soong_config_set,tinycompress,loop_compress_read,true)
$(call soong_config_set,tinycompress,enable_extended_compress_format,true)

# Bluetooth
PRODUCT_PACKAGES += \
    libbluetooth_audio_session

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.qcom.bluetooth.aac_vbr_ctl.enabled=false \
    persist.vendor.qcom.bluetooth.enable.splita2dp=true \
    persist.vendor.qcom.bluetooth.scram.enabled=true \
    persist.vendor.qcom.bluetooth.soc=cherokee \
    persist.vendor.qcom.bluetooth.twsp_state.enabled=false \
    persist.vendor.bluetooth.modem_nv_support=true \
    ro.vendor.bluetooth.wipower=false \
    vendor.qcom.bluetooth.soc=cherokee

PRODUCT_SYSTEM_PROPERTIES += \
    persist.bluetooth.bqr.event_mask=14 \
    persist.bluetooth.bqr.min_interval_ms=500

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

# Charger
PRODUCT_PACKAGES += \
    charger_res_images \
    charger_res_images_vendor \
    product_charger_res_images_vendor

# Configstore
PRODUCT_PACKAGES += \
    disable_configstore

# DebugFS
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Display
TARGET_USE_AIDL_QTI_MEMTRACK := true

# Display Device Config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display/display_id_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_0.xml

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1-service.r5x \
    android.hardware.biometrics.fingerprint@2.3-service.rbs

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# FM
BOARD_HAVE_QCOM_FM := true

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1-impl-qti:64 \
    android.hardware.gnss@2.1-service-qti \
    libbatching \
    libgeofencing \
    libgnss

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/gps/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.r5x \
    android.hardware.health-service.r5x_recovery

# Init
PRODUCT_PACKAGES += \
    init.oppo.fingerprints.sh \
    init.qti.dcvs.sh \
    set_baseband.sh \
    fstab.qcom \
    init.msm.usb.configfs.rc \
    init.oppo.fingerprints.rc \
    init.oppo.reserve.rc \
    init.r5x.rc \
    init.target.rc \
    init.uclamp.rc \
    ueventd.r5x.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom

# IRSC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config

# Kernel
PRODUCT_ENABLE_UFFD_GC := true

# Lights
PRODUCT_PACKAGES += \
    android.hardware.lights-service.r5x

# Media
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/configs/media/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
        $(LOCAL_PATH)/configs/media/media_codecs_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2.xml \
        $(LOCAL_PATH)/configs/media/media_codecs_performance_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_c2.xml \
        $(LOCAL_PATH)/configs/media/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml

TARGET_SUPPORTS_OMX_SERVICE := false

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2-service \
    NfcNci \
    nqnfcinfo \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf \
    $(LOCAL_PATH)/nfc/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf \
    $(LOCAL_PATH)/nfc/libese-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libese-nxp.conf \
    $(LOCAL_PATH)/nfc/libnfc-nxp_RF.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp_RF.conf \
    $(LOCAL_PATH)/nfc/libnfc-nxp-pnscr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp-pnscr.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_nfc_ese/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_nfc_ese/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_nfc_ese/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_nfc_ese/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_nfc_ese/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_nfc_ese/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_nfc_ese/com.nxp.mifare.xml

# Overlays
PRODUCT_PACKAGES += \
    SettingsAospaR5x \
    SystemUIAospaR5x \
    FrameworksAospaR5x

# Partitions
PRODUCT_PACKAGES += \
    vendor_bt_firmware_mountpoint \
    vendor_dsp_mountpoint \
    vendor_firmware_mnt_mountpoint

# PRODUCT_SHIPPING_API_LEVEL indicates the first api level, device has been commercially launched on.
PRODUCT_SHIPPING_API_LEVEL := 28

# Platform
TRINKET := trinket
TARGET_BOARD_PLATFORM := $(TRINKET)

# QTI
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    alarm \
    av \
    bt \
    charging \
    display \
    init \
    overlay \
    perf \
    telephony \
    usb \
    vibrator \
    wfd \
    wlan

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.multihal

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml

# Task Profiles
PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/task_profiles.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json \
    system/core/libprocessgroup/profiles/cgroups.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.mock

# Update
AB_OTA_UPDATER := false

# VNDK
BOARD_SHIPPING_API_LEVEL := 30

# Wifi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

PRODUCT_PACKAGES += \
    firmware_WCNSS_qcom_cfg.ini_symlink \
    firmware_wlan_mac.bin_symlink

# Inherit the proprietary files
$(call inherit-product, vendor/realme/r5x/r5x-vendor.mk)
