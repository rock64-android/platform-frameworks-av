LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
        MediaSender.cpp                 \
        Parameters.cpp                  \
        rtp/RTPSender.cpp               \
        source/Converter.cpp            \
        source/MediaPuller.cpp          \
        source/PlaybackSession.cpp      \
        source/RepeaterSource.cpp       \
        source/TSPacketizer.cpp         \
        source/WifiDisplaySource.cpp    \
        VideoFormats.cpp                \

LOCAL_C_INCLUDES:= \
        $(TOP)/frameworks/av/media/libstagefright \
        $(TOP)/frameworks/native/include/media/openmax \
        $(TOP)/frameworks/av/media/libstagefright/mpeg2ts \
        $(TOP)/frameworks/native/include \
        $(TOP)/hardware/rockchip/librkvpu \
        $(TOP)/hardware/rockchip/libgralloc \
	$(TOP)/hardware/include

LOCAL_SHARED_LIBRARIES:= \
        libbinder                       \
        libcutils                       \
        liblog                          \
        libgui                          \
        libmedia                        \
        libstagefright                  \
        libstagefright_foundation       \
        libui                           \
        libutils                        \
        libvpu                          \

ifeq ($(strip $(TARGET_BOARD_PLATFORM_GPU)),G6110)
        LOCAL_CFLAGS += -DPOWERVR_GPU_G6110
endif

#LOCAL_CFLAGS += -Wno-multichar -Werror -Wall
LOCAL_CLANG := true

LOCAL_MODULE:= libstagefright_wfd

ifeq ($(strip $(GRAPHIC_MEMORY_PROVIDER)),dma_buf)
LOCAL_CFLAGS += -DUSE_DMA_BUF
endif

ifeq ($(strip $(TARGET_BOARD_PLATFORM_GPU)), mali-t720)
LOCAL_CFLAGS += -DMALI_PRODUCT_ID_T72X=1
LOCAL_CFLAGS += -DMALI_AFBC_GRALLOC=0
endif

ifeq ($(strip $(TARGET_BOARD_PLATFORM_GPU)), mali-t760)
LOCAL_CFLAGS += -DMALI_PRODUCT_ID_T76X=1
LOCAL_CFLAGS += -DMALI_AFBC_GRALLOC=1
endif

ifeq ($(strip $(TARGET_BOARD_PLATFORM_GPU)), mali-t860)
LOCAL_CFLAGS += -DMALI_PRODUCT_ID_T86X=1
LOCAL_CFLAGS += -DMALI_AFBC_GRALLOC=1
endif

LOCAL_MODULE_TAGS:= optional

include $(BUILD_SHARED_LIBRARY)
