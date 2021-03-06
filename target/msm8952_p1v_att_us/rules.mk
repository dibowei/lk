LOCAL_DIR := $(GET_LOCAL_DIR)

INCLUDES += -I$(LOCAL_DIR)/include -I$(LK_TOP_DIR)/platform/msm_shared
INCLUDES += -I$(LK_TOP_DIR)/dev/gcdb/display -I$(LK_TOP_DIR)/dev/gcdb/display/include

PLATFORM := msm8952

MEMBASE := 0x8F600000 # SDRAM
#MEMSIZE := 0x00100000 # 1MB
MEMSIZE := 0x30000000 # 768MB

BASE_ADDR        := 0x80000000
SCRATCH_ADDR     := 0xC0000000

DEFINES += DISPLAY_SPLASH_SCREEN=1
DEFINES += DISPLAY_TYPE_MIPI=1
DEFINES += DISPLAY_TYPE_DSI6G=1

MODULES += \
	dev/keys \
	lib/ptable \
	dev/pmic/pm8x41 \
	lib/libfdt \
	dev/qpnp_wled \
	dev/gcdb/display

ifeq ($(ENABLE_QPNP_HAPTIC_SUPPORT),true)
MODULES += \
	dev/vib
endif

DEFINES += \
	MEMSIZE=$(MEMSIZE) \
	MEMBASE=$(MEMBASE) \
	BASE_ADDR=$(BASE_ADDR) \
	SCRATCH_ADDR=$(SCRATCH_ADDR)


OBJS += \
	$(LOCAL_DIR)/init.o \
	$(LOCAL_DIR)/meminfo.o \
	$(LOCAL_DIR)/oem_panel.o
ifeq ($(ENABLE_SMD_SUPPORT),1)
OBJS += \
	$(LOCAL_DIR)/regulator.o
endif

DEFINES += LGE_WITH_SERIAL_NUMBER

KSUT_KEYALIAS := ksut_atnt_msm8909

include platform/lge_shared/rules.mk
include target/msm8952_common/rules.mk

