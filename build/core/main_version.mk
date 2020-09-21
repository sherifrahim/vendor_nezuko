# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# NezukoOS System Version
ADDITIONAL_BUILD_PROPERTIES += \
  ro.nezuko.version=$(NEZUKO_DISPLAY_VERSION) \
  ro.nezuko.build.status=$(NEZUKO_BUILDTYPE) \
  ro.modversion=$(NEZUKO_MOD_VERSION) \
  ro.nezuko.build.date=$(BUILD_DATE) \
  ro.nezuko.buildtype=$(NEZUKO_BUILDTYPE) \
  ro.nezuko.fingerprint=$(NEZUKO_FINGERPRINT) \
  ro.nezuko.device=$(NEZUKO_BUILD) 
