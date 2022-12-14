DLKM_DIR := motorola/kernel/modules
LOCAL_PATH := $(call my-dir)

ifeq ($(DLKM_INSTALL_TO_VENDOR_OUT),true)
CHIPONE_MMI_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/modules/
else
CHIPONE_MMI_MODULE_PATH := $(KERNEL_MODULES_OUT)
endif
ifeq ($(CHIPONE_ESD),true)
	KERNEL_CFLAGS += CONFIG_CHIPONE_ESD=y
endif

ifneq ($(BOARD_USES_DOUBLE_TAP),)
	KERNEL_CFLAGS += CONFIG_INPUT_CHIPONE_0FLASH_MMI_ENABLE_DOUBLE_TAP=y
endif

ifneq ($(BOARD_USES_PANEL_NOTIFICATIONS),)
	KERNEL_CFLAGS += CONFIG_INPUT_CHIPONE_PANEL_NOTIFICATIONS=y
endif

ifneq ($(MOTO_PANEL_CHECK_TOUCH_STATE),)
	KERNEL_CFLAGS += CONFIG_INPUT_CHIPONE_0FLASH_MMI_NOTIFY_TOUCH_STATE=y
endif

include $(CLEAR_VARS)
ifneq ($(BOARD_USES_DOUBLE_TAP),)
LOCAL_ADDITIONAL_DEPENDENCIES += $(KERNEL_MODULES_OUT)/sensors_class.ko
endif
LOCAL_MODULE := chipone_tddi_fhd_mmi.ko
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(CHIPONE_MMI_MODULE_PATH)
include $(DLKM_DIR)/AndroidKernelModule.mk
