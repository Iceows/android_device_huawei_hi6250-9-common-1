#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

## Project ID Quota
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit release key 
$(call inherit-product-if-exists, vendor/extra/product.mk)

# Inherit the proprietary files
$(call inherit-product, vendor/huawei/hi6250-9-common/hi6250-9-common-vendor.mk)

# Audio
$(call soong_config_set,android_hardware_audio,run_64bit,true)
$(call soong_config_set,huaweiAudioVars,emui_version,9)


PRODUCT_PACKAGES += \
    android.hardware.audio@4.0-impl-hisi \
    android.hardware.audio.effect@4.0-impl \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl \

PRODUCT_PACKAGES += \
    audio.bluetooth.default \
    audio.primary.hi6250 \
    audio.r_submix.default \
    audio.usb.default

PRODUCT_PACKAGES += \
    libaudiopreprocessing \
    libtinycompress \
    libaudioroute \
    libtinyalsa \
    libalsautils

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# Binder
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0.vendor \
    android.hidl.memory@1.0.vendor

PRODUCT_PACKAGES += \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder.vendor \
    libhwbinder

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service

PRODUCT_PACKAGES += \
    libbt-vendor

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl

PRODUCT_PACKAGES += \
    vendor.huawei.hardware.biometrics.hwfacerecognize@1.1.vendor \
    vendor.huawei.hardware.hwfactoryinterface@1.0.vendor \
    vendor.huawei.hardware.hwfactoryinterface@1.1.vendor \
    vendor.huawei.hardware.sensors@1.0.vendor

PRODUCT_PACKAGES += \
    libstdc++.vendor \
    libui_shim.vendor

# Charger
PRODUCT_PACKAGES += \
    charger_res_images_vendor

# Connectivity
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/rootdir/etc/connectivity/,$(TARGET_COPY_OUT_VENDOR)/etc/init/connectivity)

# ConfigStore
PRODUCT_PACKAGES += \
    disable_configstore

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.2-service \
    android.hardware.graphics.mapper@2.0-impl

PRODUCT_PACKAGES += \
    libion

PRODUCT_PACKAGES += \
    libui-v28

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey \
    android.hardware.drm@1.2.vendor

PRODUCT_PACKAGES += \
    libmockdrmcryptoplugin

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/etc/init/android.hardware.drm@1.2-service.widevine.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.drm@1.2-service.widevine.rc

PRODUCT_PACKAGES += \
    android.hardware.drm@1.2-service.widevine \
    libwvhidl \
    liboemcrypto

PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-v29 \
    libprotobuf-cpp-lite-v29

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    vendor.huawei.hardware.biometrics.fingerprint@2.1.vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/fingerprint.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/fingerprint.kl

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.gatekeeper@1.0-impl

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service \
    com.android.future.usb.accessory

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0.vendor \
    android.hardware.gnss@1.1.vendor

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/permissions/,$(TARGET_COPY_OUT_SYSTEM)/etc/permissions)

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.hisi \
    android.hardware.health-service.hisi-recovery

# Hisi
PRODUCT_PACKAGES += \
    hisi_init

# Huawei (stubs)
PRODUCT_PACKAGES += \
    libchrlog \
    libhwlog \
    libimonitor \
    libxcollie

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-service

PRODUCT_PACKAGES += \
    libkeymaster3device.vendor \
    libkeystore-engine-wifi-hidl \
    libkeystore-wifi-hidl

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light-service.huawei

# Livedisplay
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay@2.1-service.hisi

# Media
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/media/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2-service \
    com.android.nfc_extras \
    NfcNci \
    Tag

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_ENFORCE_RRO_TARGETS := *

PRODUCT_PACKAGES += \
    TetheringResOverlayHI6250-9 \
    WifiResOverlayHI6250-9

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.external.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.external.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_0_3.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.huawei-libperfmgr

PRODUCT_PACKAGES += \
    vendor.huawei.hardware.perfgenius@2.0.vendor

PRODUCT_PACKAGES += \
    libiawareperf_client \
    libperfgenius_vendor_client

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Radio
PRODUCT_PACKAGES += \
    android.hardware.radio@1.2.vendor \
    android.hardware.radio.deprecated@1.0.vendor

PRODUCT_PACKAGES += \
    libril \
    librilutils

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.hi6250 \
    fstab.hi6250_ramdisk \
    fstab.modem \
    init.hi6250.rc \
    init.hi6250.usb.rc \
    init.override.rc \
    init.performance.rc \
    ueventd.hi6250.rc

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/rootdir/etc/connectivity/,$(TARGET_COPY_OUT_VENDOR)/etc/init/connectivity)

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/rootdir/etc/charger/,$(TARGET_COPY_OUT_VENDOR)/etc/init/charger)

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.recovery.hi6250.rc:$(TARGET_RECOVERY_OUT)/root/init.recovery.hi6250.rc

# Secure Element
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2.vendor \
    android.hardware.secure_element@1.0.vendor

# Sensors
PRODUCT_PACKAGES += \
    android.frameworks.sensorservice@1.0.vendor \
    android.hardware.sensors@1.0-impl \
    android.hardware.sensors@1.0-service

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/google/interfaces \
    hardware/google/pixel \
    hardware/hisi \
    hardware/huawei \
    hardware/huawei/power-libperfmgr

# Task profiles
PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/cgroups_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    system/core/libprocessgroup/profiles/task_profiles_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

# TEE
PRODUCT_PACKAGES += \
    vendor.huawei.hardware.libteec@2.0 \
    vendor.huawei.hardware.libteec@2.0.vendor

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0-impl \
    android.hardware.thermal@1.0-service

# Trust HAL
PRODUCT_PACKAGES += \
    vendor.lineage.trust@1.0-service

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service

PRODUCT_PACKAGES += \
    vendor.huawei.hardware.hwvibrator@1.0.vendor
    
# IME Input
PRODUCT_PACKAGES += \
    libjni_latinimegoogle
    
# AGPS Supl20
PRODUCT_PACKAGES += \
    gnss_supl20service_hisi

PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/system/etc/gnss/config/gnss_suplconfig_hisi.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/gnss/config/gnss_suplconfig_hisi.xml \
     $(LOCAL_PATH)/system/etc/permissions/privapp-permissions-supl.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-supl.xml

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

-include hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk


