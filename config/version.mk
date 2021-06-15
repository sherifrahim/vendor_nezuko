# Copyright (C) 2021 NezukoOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ANDROID_VERSION := 11.0
NEZUKOVERSION := v1.4

NEZUKO_BUILDTYPE ?= UNOFFICIAL
NEZUKO_BUILD_DATE := $(shell date +%Y%m%d)
TARGET_PRODUCT_SHORT := $(subst nezuko_,,$(NEZUKO_BUILD))

# OFFICIAL_DEVICES
ifeq ($(NEZUKO_BUILDTYPE), OFFICIAL)
  LIST = $(shell cat vendor/nezuko/nezuko.devices)
    ifeq ($(filter $(NEZUKO_BUILD), $(LIST)), $(NEZUKO_BUILD))
      IS_OFFICIAL=true
      NEZUKO_BUILDTYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      NEZUKO_BUILDTYPE := UNOFFICIAL
      $(error Device is not official "$(NEZUKO_BUILD)")
    endif
endif

# MAIN
NEZUKO_VERSION := $(NEZUKOVERSION)-$(NEZUKO_BUILD)-$(NEZUKO_BUILD_DATE)-$(NEZUKO_BUILDTYPE)

NEZUKO_MOD_VERSION :=$(ANDROID_VERSION)-$(NEZUKOVERSION)

NEZUKO_DISPLAY_VERSION := NezukoOS-$(NEZUKOVERSION)-$(NEZUKO_BUILDTYPE)

NEZUKO_DISPLAY_BUILDTYPE := $(NEZUKO_BUILDTYPE)

NEZUKO_FINGERPRINT := NezukoOS/$(NEZUKO_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)