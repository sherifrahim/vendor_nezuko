include vendor/nezuko/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/nezuko/config/BoardConfigQcom.mk
endif

include vendor/nezuko/config/BoardConfigSoong.mk
