# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= Radiant

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

TARGET_INCLUDE_GAPPS ?= true
TARGET_INCLUDE_STOCK_ARCORE ?= false
TARGET_INCLUDE_GOOGLE_RECORDER ?= false

# Priv-app permissions
PRODUCT_COPY_FILES += \
    vendor/radiant/prebuilt/common/etc/permissions/privapp-permissions-radiant.xml:system/etc/permissions/privapp-permissions-radiant.xml \
    vendor/radiant/prebuilt/common/etc/permissions/com.maitreya.nezukoextras.xml:system/etc/permissions/com.maitreya.nezukoextras.xml

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif


# Plugins
include packages/apps/Plugins/plugins.mk

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/radiant/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/radiant/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/radiant/prebuilt/common/bin/50-lineage.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-lineage.sh

# Permissions
PRODUCT_COPY_FILES += \
    vendor/radiant/config/permissions/privapp-permissions-system_ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-system_ext.xml \

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/radiant/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/radiant/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/radiant/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

ifeq ($(TARGET_INCLUDE_GAPPS), true)
ifeq ($(RADIANT_BUILD_TYPE), OFFICIAL)
PRODUCT_PACKAGES += \
    Updater
endif
endif
# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/radiant/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Copy all Radiant-specific init rc files
$(foreach f,$(wildcard vendor/radiant/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/radiant/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/radiant/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log

# Include AOSP audio files
#include vendor/radiant/config/aosp_audio.mk

# Include Radiant audio files
#include vendor/radiant/config/radiant_audio.mk

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/radiant/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Root
PRODUCT_PACKAGES += \
    adb_root

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    TrebuchetQuickStep

# Fonts
PRODUCT_PACKAGES += \
    Custom-Fonts

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/radiant/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/radiant/overlay/common

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/radiant/config/partner_gms.mk

# Versioning
include vendor/radiant/config/version.mk

# BootAnimation
-include vendor/radiant/config/bootanimation.mk

# Include extra packages
include vendor/radiant/config/packages.mk
include packages/overlays/Themes/themes.mk

# Include Nezextras
include vendor/nezextras/nezextras.mk


# Inherit GAPPS
ifeq ($(TARGET_INCLUDE_GAPPS), true)
include vendor/gapps/config.mk
endif
