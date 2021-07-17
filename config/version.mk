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
NEZUKOVERSION := 1.4

NEZUKO_BUILD_TYPE ?= UNOFFICIAL
NEZUKO_DATE_YEAR := $(shell date -u +%Y)
NEZUKO_DATE_MONTH := $(shell date -u +%m)
NEZUKO_DATE_DAY := $(shell date -u +%d)
NEZUKO_DATE_HOUR := $(shell date -u +%H)
NEZUKO_DATE_MINUTE := $(shell date -u +%M)
NEZUKO_BUILD_DATE_UTC := $(shell date -d '$(NEZUKO_DATE_YEAR)-$(NEZUKO_DATE_MONTH)-$(NEZUKO_DATE_DAY) $(NEZUKO_DATE_HOUR):$(NEZUKO_DATE_MINUTE) UTC' +%s)
NEZUKO_BUILD_DATE := $(NEZUKO_DATE_YEAR)$(NEZUKO_DATE_MONTH)$(NEZUKO_DATE_DAY)-$(NEZUKO_DATE_HOUR)$(NEZUKO_DATE_MINUTE)
TARGET_PRODUCT_SHORT := $(subst nezuko_,,$(NEZUKO_BUILD))

# OFFICIAL_DEVICES
ifeq ($(NEZUKO_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/nezuko/nezuko.devices)
    ifeq ($(filter $(NEZUKO_BUILD), $(LIST)), $(NEZUKO_BUILD))
      IS_OFFICIAL=true
      NEZUKO_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      NEZUKO_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(NEZUKO_BUILD)")
    endif
endif

ifeq ($(TARGET_INCLUDE_GAPPS),true)
NEZUKO_VERSION := $(NEZUKOVERSION)-GAPPS-$(NEZUKO_BUILD)-$(NEZUKO_BUILD_DATE)-$(NEZUKO_BUILD_TYPE)
else
NEZUKO_VERSION := $(NEZUKOVERSION)-VANILLA-$(NEZUKO_BUILD)-$(NEZUKO_BUILD_DATE)-$(NEZUKO_BUILD_TYPE)
endif

NEZUKO_MOD_VERSION :=$(ANDROID_VERSION)-$(NEZUKOVERSION)

NEZUKO_DISPLAY_VERSION := NezukoOS-$(NEZUKOVERSION)-$(NEZUKO_BUILD_TYPE)

NEZUKO_DISPLAY_BUILDTYPE := $(NEZUKO_BUILD_TYPE)

NEZUKO_FINGERPRINT := NezukoOS/$(NEZUKO_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)