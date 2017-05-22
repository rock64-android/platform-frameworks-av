LOCAL_PATH:= $(call my-dir)

#
# libmediaplayerservice
#

include $(CLEAR_VARS)
ifneq ($(filter rk%, $(TARGET_BOARD_PLATFORM)), )
LOCAL_CFLAGS := -DAVS50
BUILD_FF_PLAYER := true
else
BUILD_FF_PLAYER := false
endif

LOCAL_SRC_FILES:=               \
    ActivityManager.cpp         \
    HDCP.cpp                    \
    MediaPlayerFactory.cpp      \
    MediaPlayerService.cpp      \
    MediaRecorderClient.cpp     \
    MetadataRetrieverClient.cpp \
    RemoteDisplay.cpp           \
    StagefrightRecorder.cpp     \
    TestPlayerStub.cpp          \
    MidiFile.cpp                \
    MidiMetadataRetriever.cpp   \

LOCAL_SHARED_LIBRARIES :=       \
    libbinder                   \
    libcamera_client            \
    libcrypto                   \
    libcutils                   \
    libdrmframework             \
    liblog                      \
    libdl                       \
    libgui                      \
    libmedia                    \
    libmediautils               \
    libmemunreachable           \
    libsonivox                  \
    libstagefright              \
    libstagefright_foundation   \
    libstagefright_httplive     \
    libstagefright_omx          \
    libstagefright_wfd          \
    libutils                    \
    libvorbisidec               \

LOCAL_STATIC_LIBRARIES :=       \
    libstagefright_nuplayer     \
    libstagefright_rtsp         \
    libstagefright_timedtext    \

LOCAL_C_INCLUDES :=                                                 \
    $(TOP)/frameworks/av/media/libstagefright                       \
    $(TOP)/frameworks/av/media/libstagefright/include               \
    $(TOP)/frameworks/av/media/libstagefright/rtsp                  \
    $(TOP)/frameworks/av/media/libstagefright/wifi-display          \
    $(TOP)/frameworks/av/media/libstagefright/webm                  \
    $(TOP)/frameworks/av/include/media                              \
    $(TOP)/frameworks/av/include/camera                             \
    $(TOP)/frameworks/native/include/media/openmax                  \
    $(TOP)/frameworks/native/include/media/hardware                 \
    $(TOP)/external/tremolo/Tremolo                                 \
    libcore/include                                                 \

ifeq ($(strip $(BUILD_FF_PLAYER)),true)
LOCAL_SRC_FILES += \
    FFPlayer.cpp

LOCAL_CFLAGS += \
    -DUSE_FFPLAYER

LOCAL_SHARED_LIBRARIES += \
    librkffplayer

LOCAL_C_INCLUDES += \
    $(TOP)/frameworks/av/media/libstagefright/libvpu/common             \
    $(TOP)/frameworks/av/media/libstagefright/libvpu/common/include \
    $(TOP)/hardware/rockchip/librkvpu                               \
    $(TOP)/frameworks/av/media/rk_ffplayer
endif
LOCAL_CFLAGS += -Werror -Wno-error=deprecated-declarations -Wall -Wno-error=unused-parameter -Wno-error=unused-function -Wno-error=unused-variable


LOCAL_CLANG := true

LOCAL_MODULE:= libmediaplayerservice

LOCAL_32_BIT_ONLY := true

include $(BUILD_SHARED_LIBRARY)

include $(call all-makefiles-under,$(LOCAL_PATH))
