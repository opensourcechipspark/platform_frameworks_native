LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	IGraphicBufferConsumer.cpp \
	IConsumerListener.cpp \
	BitTube.cpp \
	BufferItemConsumer.cpp \
	BufferQueue.cpp \
	ConsumerBase.cpp \
	CpuConsumer.cpp \
	DisplayEventReceiver.cpp \
	GLConsumer.cpp \
	GraphicBufferAlloc.cpp \
	GuiConfig.cpp \
	IDisplayEventConnection.cpp \
	IGraphicBufferAlloc.cpp \
	IGraphicBufferProducer.cpp \
	ISensorEventConnection.cpp \
	ISensorServer.cpp \
	ISurfaceComposer.cpp \
	ISurfaceComposerClient.cpp \
	LayerState.cpp \
	Sensor.cpp \
	SensorEventQueue.cpp \
	SensorManager.cpp \
	Surface.cpp \
	SurfaceControl.cpp \
	SurfaceComposerClient.cpp \
	SyncFeatures.cpp \

LOCAL_SHARED_LIBRARIES := \
	libbinder \
	libcutils \
	libEGL \
	libGLESv2 \
	libsync \
	libui \
	libutils \
	liblog


LOCAL_MODULE:= libgui

LOCAL_CFLAGS += -DDONT_USE_FENCE_SYNC
ifeq ($(TARGET_BOARD_PLATFORM), tegra)
	LOCAL_CFLAGS += -DDONT_USE_FENCE_SYNC
endif
ifeq ($(TARGET_BOARD_PLATFORM), tegra3)
	LOCAL_CFLAGS += -DDONT_USE_FENCE_SYNC
endif

ifeq ($(strip $(TARGET_BOARD_PLATFORM_GPU)), mali400)
    LOCAL_CFLAGS += -DUSE_GRALLOC_PRIVATE_FLAG
endif

ifeq ($(strip $(BOARD_USE_LCDC_COMPOSER)),true)
LOCAL_CFLAGS += -DUSE_LCDC_COMPOSER
endif

ifeq ($(strip $(BOARD_ENABLE_WFD_SKIP_FRAME)),true)
LOCAL_CFLAGS += -DENABLE_WFD_SKIP_FRAME
endif

ifeq ($(strip $(BOARD_USE_LAUNCHER2)),true)
LOCAL_CFLAGS += -DUSE_LAUNCHER2
endif

ifeq ($(strip $(TARGET_BOARD_PLATFORM)),rk3288)
        LOCAL_CFLAGS += -DUSE_RGA_COPYBLT
endif

ifeq ($(strip $(TARGET_BOARD_PLATFORM)),rk3036)
LOCAL_CFLAGS += -DPLATFORM_RK3036
endif

ifeq ($(strip $(GRAPHIC_MEMORY_PROVIDER)),dma_buf)
LOCAL_CFLAGS += -DUSE_DMA_BUF
endif

# for fence
LOCAL_CFLAGS += -DUSE_PREPARE_FENCE

include $(BUILD_SHARED_LIBRARY)

ifeq (,$(ONE_SHOT_MAKEFILE))
include $(call first-makefiles-under,$(LOCAL_PATH))
endif
