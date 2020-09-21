# Inherit full common Lineage stuff
$(call inherit-product, vendor/nezuko/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/nezuko/overlay/dictionaries

$(call inherit-product, vendor/nezuko/config/telephony.mk)
