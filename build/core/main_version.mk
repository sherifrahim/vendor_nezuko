BUILD_NUMBER_CUSTOM := $(shell date -u +%H%M)

BUILD_SIGNATURE_KEYS := release-keys

BUILD_FINGERPRINT := $(PRODUCT_BRAND)/$(TARGET_DEVICE)/$(TARGET_DEVICE):$(PLATFORM_VERSION)/$(BUILD_ID)/$(BUILD_NUMBER_CUSTOM):$(TARGET_BUILD_VARIANT)/$(BUILD_SIGNATURE_KEYS)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT) 

# ProjectRadiant System Version
ADDITIONAL_BUILD_PROPERTIES += \
  ro.radiant.version=$(RADIANT_DISPLAY_VERSION) \
  ro.radiant.build.status=$(RADIANT_BUILD_TYPE) \
  ro.modversion=$(RADIANT_MOD_VERSION) \
  ro.radiant.build.date=$(BUILD_DATE) \
  ro.radiant.buildtype=$(RADIANT_BUILD_TYPE) \
  ro.radiant.fingerprint=$(RADIANT_FINGERPRINT) \
  ro.radiant.device=$(RADIANT_BUILD) \
  org.radiant.version=$(RADIANTVERSION)