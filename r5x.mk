#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common AxionAOSP stuff
$(call inherit-product, vendor/neoteric/target/product/neoteric-target.mk)

# Inherit from r5x device
$(call inherit-product, device/realme/r5x/device.mk)

PRODUCT_BRAND := realme
PRODUCT_DEVICE := r5x
PRODUCT_MANUFACTURER := realme
PRODUCT_NAME := r5x
PRODUCT_MODEL := realme 5 Series

PRODUCT_GMS_CLIENTID_BASE := android-oppo
