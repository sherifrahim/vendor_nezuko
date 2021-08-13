include vendor/radiant/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/radiant/config/BoardConfigQcom.mk
endif

include vendor/radiant/config/BoardConfigSoong.mk
