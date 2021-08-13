# Copyright (C) 2021 ProjectRadiant
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
RADIANTVERSION := 1.0

RADIANT_BUILD_TYPE ?= UNOFFICIAL
RADIANT_DATE_YEAR := $(shell date -u +%Y)
RADIANT_DATE_MONTH := $(shell date -u +%m)
RADIANT_DATE_DAY := $(shell date -u +%d)
RADIANT_DATE_HOUR := $(shell date -u +%H)
RADIANT_DATE_MINUTE := $(shell date -u +%M)
RADIANT_BUILD_DATE_UTC := $(shell date -d '$(RADIANT_DATE_YEAR)-$(RADIANT_DATE_MONTH)-$(RADIANT_DATE_DAY) $(RADIANT_DATE_HOUR):$(RADIANT_DATE_MINUTE) UTC' +%s)
RADIANT_BUILD_DATE := $(RADIANT_DATE_YEAR)$(RADIANT_DATE_MONTH)$(RADIANT_DATE_DAY)-$(RADIANT_DATE_HOUR)$(RADIANT_DATE_MINUTE)
TARGET_PRODUCT_SHORT := $(subst radiant_,,$(RADIANT_BUILD))

# OFFICIAL_DEVICES
ifeq ($(RADIANT_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/radiant/radiant.devices)
    ifeq ($(filter $(RADIANT_BUILD), $(LIST)), $(RADIANT_BUILD))
      IS_OFFICIAL=true
      RADIANT_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      RADIANT_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(RADIANT_BUILD)")
    endif
endif

ifeq ($(TARGET_INCLUDE_GAPPS),true)
RADIANT_VERSION := $(RADIANTVERSION)-GAPPS-$(RADIANT_BUILD)-$(RADIANT_BUILD_DATE)-$(RADIANT_BUILD_TYPE)
else
RADIANT_VERSION := $(RADIANTVERSION)-VANILLA-$(RADIANT_BUILD)-$(RADIANT_BUILD_DATE)-$(RADIANT_BUILD_TYPE)
endif

RADIANT_MOD_VERSION :=$(ANDROID_VERSION)-$(RADIANTVERSION)

RADIANT_DISPLAY_VERSION := ProjectRadiant-$(RADIANTVERSION)-$(RADIANT_BUILD_TYPE)

RADIANT_DISPLAY_BUILDTYPE := $(RADIANT_BUILD_TYPE)

RADIANT_FINGERPRINT := ProjectRadiant/$(RADIANT_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)