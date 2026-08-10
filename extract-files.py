#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.file import File
from extract_utils.fixups_blob import (
    BlobFixupCtx,
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.tools import (
    llvm_objdump_path,
)
from extract_utils.utils import (
    run_cmd,
)

namespace_imports = [
    'device/realme/r5x',
    'vendor/qcom/common/vendor/gps-legacy',
    'hardware/qcom/display',
    'hardware/qcom/display/gralloc',
    'hardware/qcom/display/libdebug',
    'vendor/qcom/common/vendor/adreno-r',
    'vendor/qcom/common/vendor/display/4.14',
    'vendor/qcom/common/vendor/media-legacy',
    'vendor/qcom/common/vendor/perf',
    'vendor/qcom/common/vendor/wlan',
    'vendor/qcom/opensource/dataservices',
    'vendor/qcom/opensource/data-ipa-cfg-mgr',
    'vendor/qcom/common/system/telephony',
    'vendor/realme/r5x',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'com.qualcomm.qti.dpm.api@1.0',
        'com.qualcomm.qti.imscmservice*',
        'com.qualcomm.qti.uceservice*',
        'libmmosal',
        'vendor.qti.data.*',
        'vendor.qti.hardware.data.*',
        'vendor.qti.hardware.fm@1.0',
        'vendor.qti.hardware.mwqemadapter@1.0',
        'vendor.qti.hardware.radio.am@1.0',
        'vendor.qti.hardware.radio.ims@*',
        'vendor.qti.hardware.radio.internal.deviceinfo@1.0',
        'vendor.qti.hardware.radio.lpa*',
        'vendor.qti.hardware.radio.qcrilhook@1.0',
        'vendor.qti.hardware.radio.qtiradio*',
        'vendor.qti.hardware.radio.uim*',
        'vendor.qti.hardware.radio.uim_remote_client*',
        'vendor.qti.hardware.radio.uim_remote_server@1.0',
        'vendor.qti.hardware.wifidisplaysession@1.0',
        'vendor.qti.ims.callcapability@1.0',
        'vendor.qti.ims.callinfo@1.0',
        'vendor.qti.ims.factory*',
        'vendor.qti.ims.rcsconfig*',
        'vendor.qti.imsrtpservice@3.0',
        'vendor.qti.latency*',
    ): lib_fixup_vendor_suffix,
    'libwpa_client': lib_fixup_remove,
}

blob_fixups: blob_fixups_user_type = {
    ('vendor/lib/libOPPORectify.so', 'vendor/lib/libarcsoft_beautyshot_lite_image.so', 'vendor/lib/libarcsoft_hdr_couple_api.so', 'vendor/lib/libarcsoft_high_dynamic_range_couple.so', 'vendor/lib/libarcsoft_picauto.so', 'vendor/lib/libblur_channel.so', 'vendor/lib/libthread_blur.so', 'vendor/lib/libdepthmap.so'): blob_fixup()
        .replace_needed('libstdc++.so', 'libstdc++_vendor.so'),
    'vendor/lib64/libwvhidl.so': blob_fixup()
        .add_needed('libcrypto_shim.so')
}  # fmt: skip

module = ExtractUtilsModule(
    'r5x',
    'realme',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
