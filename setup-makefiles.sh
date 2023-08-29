#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=r5x
VENDOR=realme

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

export TARGET_ENABLE_CHECKELF=true

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

function vendor_imports() {
    cat <<EOF >>"$1"
       "device/realme/r5x",
       "vendor/qcom/common/vendor/gps-legacy",
       "hardware/qcom/display",
       "hardware/qcom/display/gralloc",
       "hardware/qcom/display/libdebug",
       "vendor/qcom/common/vendor/adreno-r",
       "vendor/qcom/common/vendor/display/4.14",
       "vendor/qcom/common/vendor/media-legacy",
       "vendor/qcom/common/vendor/perf",
       "vendor/qcom/common/vendor/wlan",
       "vendor/qcom/opensource/dataservices",
       "vendor/qcom/opensource/data-ipa-cfg-mgr",
       "vendor/qcom/common/system/telephony",
       "vendor/realme/r5x",
EOF
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}"

# Warning headers and guards
write_headers

write_makefiles "${MY_DIR}/proprietary-files.txt" true

# Finish
write_footers
