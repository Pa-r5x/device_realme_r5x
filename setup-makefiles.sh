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

function lib_to_package_fixup_vendor_variants() {
    if [ "$2" != "vendor" ]; then
        return 1
    fi

    case "$1" in
            com.qualcomm.qti.dpm.api@1.0 | \
            com.qualcomm.qti.imscmservice* | \
            com.qualcomm.qti.uceservice* | \
            libmmosal | \
            vendor.qti.data.* | \
            vendor.qti.hardware.data.* | \
            vendor.qti.hardware.fm@1.0 | \
            vendor.qti.hardware.mwqemadapter@1.0 | \
            vendor.qti.hardware.radio.am@1.0 | \
            vendor.qti.hardware.radio.ims@* | \
            vendor.qti.hardware.radio.internal.deviceinfo@1.0 | \
            vendor.qti.hardware.radio.lpa* | \
            vendor.qti.hardware.radio.qcrilhook@1.0 | \
            vendor.qti.hardware.radio.qtiradio* | \
            vendor.qti.hardware.radio.uim* | \
            vendor.qti.hardware.radio.uim_remote_client* | \
            vendor.qti.hardware.radio.uim_remote_server@1.0 | \
            vendor.qti.hardware.wifidisplaysession@1.0 | \
            vendor.qti.ims.callcapability@1.0 | \
            vendor.qti.ims.callinfo@1.0 | \
            vendor.qti.ims.factory* | \
            vendor.qti.ims.rcsconfig* | \
            vendor.qti.imsrtpservice@3.0 | \
            vendor.qti.latency*)
            echo "${1}_vendor"
            ;;
        *)
            return 1
            ;;
    esac
}

function lib_to_package_fixup() {
    lib_to_package_fixup_clang_rt_ubsan_standalone "$1" ||
        lib_to_package_fixup_proto_3_9_1 "$1" ||
        lib_to_package_fixup_vendor_variants "$@"
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}"

# Warning headers and guards
write_headers

write_makefiles "${MY_DIR}/proprietary-files.txt" true

# Finish
write_footers
