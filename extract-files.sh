#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_COMMON=
ONLY_TARGET=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-common )
                ONLY_COMMON=true
                ;;
        --only-target )
                ONLY_TARGET=true
                ;;
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/etc/camera/*|odm/etc/camera/*)
            sed -i 's/gb2312/iso-8859-1/g' "${2}"
            sed -i 's/GB2312/iso-8859-1/g' "${2}"
            sed -i 's/xmlversion/xml version/g' "${2}"
            ;;
        vendor/etc/init/android.hardware.drm@1.1-service.widevine.rc)
            sed -i 's/preavs/vendor/g' "${2}"
            ;;
        vendor/etc/init/android.hardware.secure_element@1.0-service.hisi.rc)
            sed -i 's/1.0-service/1.0-service.hisi/g' "${2}"
            ;;
        vendor/etc/init/rild.rc)
            sed -i '1i on property:sys.rilprops_ready=1\n    start vendor.ril-daemon\n' "${2}"
            echo "    disabled" >> "${2}"
            ;;
        vendor/lib64/hw/audio.primary.hi6250.so)
            "${PATCHELF}" --add-needed "libprocessgroup.so" "${2}"
            ;;
        vendor/lib*/hw/gralloc.hi6250.so)
	    "${PATCHELF}" --add-needed "libhidlbase.so" "${2}"
            ;;
        vendor/lib*/hw/hwcomposer.hi6250.so)
            "${PATCHELF}" --replace-needed "libui.so" "libui-v28.so" "${2}"
            ;;
        vendor/lib64/libbt-vendor-bcm.so)
            "${PATCHELF}" --set-soname "libbt-vendor-bcm.so" "${2}"
            ;;
        vendor/lib*/libcamera_algo.so)
            "${PATCHELF}" --add-needed "libui_shim.so" "${2}"
            ;;
        vendor/lib*/libril-hisi.so)
            "${PATCHELF}" --set-soname "libril-hisi.so" "${2}"
            ;;
        vendor/lib*/libwvhidl.so)
            "${PATCHELF}" --replace-needed "libprotobuf-cpp-lite.so" "libprotobuf-cpp-lite-v29.so" "${2}"
            ;;
        # Replace fmservice name by OSS fmservice name
        lib*/libfm_jni.so)
            sed -i 's|com/huawei/android/hardware/fmradio/FmReceiverJNI|com/android/server/FmReceiverJNI\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00|g' "${2}"
            ;;
    esac
}

if [ -z "${ONLY_TARGET}" ]; then
    # Initialize the helper for common device
    setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

if [ -z "${ONLY_COMMON}" ] && [ -s "${MY_DIR}/../${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    source "${MY_DIR}/../${DEVICE}/extract-files.sh"
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

    extract "${MY_DIR}/../${DEVICE}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

"${MY_DIR}/setup-makefiles.sh"
