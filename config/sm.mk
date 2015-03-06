# Copyright (C) 2014-2015 The SaberMod Project
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
#

# Set GCC colors
export GCC_COLORS := 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Find host os
UNAME := $(shell uname -s)

ifeq ($(strip $(UNAME)),Linux)
  HOST_OS := linux
endif

# Only use these compilers on linux host.
ifeq ($(strip $(HOST_OS)),linux)

  ifeq ($(strip $(TARGET_ARCH)),arm)

      OPT1 := (graphite)

      # Graphite flags and friends
      GRAPHITE_FLAGS := \
        -fgraphite \
        -fgraphite-identity \
        -floop-flatten \
        -floop-parallelize-all \
        -ftree-loop-linear \
        -floop-interchange \
        -floop-strip-mine \
        -floop-block

      # Legacy gcc doesn't understand this flag
      ifneq ($(strip $(USE_LEGACY_GCC)),true)
        GRAPHITE_FLAGS += \
          -Wno-error=maybe-uninitialized
      endif
    endif

        # Graphite flags for kernel
        export GRAPHITE_KERNEL_FLAGS := \
                 -fgraphite \
                 -fgraphite-identity \
                 -floop-flatten \
                 -floop-parallelize-all \
                 -ftree-loop-linear \
                 -floop-interchange \
                 -floop-strip-mine \
                 -floop-block

endif

  # Add extra libs for the compilers to use
  export LD_LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LD_LIBRARY_PATH)
  export LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LIBRARY_PATH)
  # Force disable some modules that are not compatible with graphite flags.
  # Add more modules if needed for devices in BoardConfig.mk
  # LOCAL_DISABLE_GRAPHITE +=
  LOCAL_DISABLE_GRAPHITE := \
    libunwind \
    libFFTEm \
    libicui18n \
    libskia \
    libvpx \
    libmedia_jni \
    libstagefright_mp3dec \
    libart \
    mdnsd \
    libwebrtc_spl \
    third_party_WebKit_Source_core_webcore_svg_gyp \
    libjni_filtershow_filters \
    libavformat \
    libavcodec \
    skia_skia_library_gyp \
    libSR_Core \
    libwebviewchromium \
    third_party_libvpx_libvpx_gyp \
    ui_gl_gl_gyp \
    libdomx \
    libOMX_Core \
    libOMX.TI.DUCATI1.VIDEO.H264E \
    libOMX.TI.DUCATI1.VIDEO.H264SVCE \
    libOMX.TI.DUCATI1.VIDEO.VC1E \
    libOMX.TI.DUCATI1.VIDEO.MPEG4E \
    libOMX.TI.DUCATI1.VIDEO.DECODER \
    libOMX.TI.DUCATI1.VIDEO.DECODER.secure \
    libOMX.TI.DUCATI1.VIDEO.CAMERA \
    libOMX.TI.DUCATI1.MISC.SAMPLE \
    libstagefrighthw \
    libI420colorconvert \
    libtiutils \
    libion_ti \
    smc_pa_ctrl \
    tf_daemon \
    libtf_crypto_sst \
    hwcomposer.omap4 \
    libion.so \
    pvrsrvinit \
    libPVRScopeServices.so \
    libcorkscrew \
    libtee_client_api_driver \
    fio

  ifeq ($(strip $(O3_OPTIMIZATIONS)),true)
    OPT2 := (max)

    # Disable some modules that break with -O3
    # Add more modules if needed for devices in BoardConfig.mk
    # LOCAL_DISABLE_O3 +=
    LOCAL_DISABLE_O3 := \
      libaudioflinger \
      libwebviewchromium \
      skia_skia_library_gyp \
    libdomx \
    libOMX_Core \
    libOMX.TI.DUCATI1.VIDEO.H264E \
    libOMX.TI.DUCATI1.VIDEO.H264SVCE \
    libOMX.TI.DUCATI1.VIDEO.VC1E \
    libOMX.TI.DUCATI1.VIDEO.MPEG4E \
    libOMX.TI.DUCATI1.VIDEO.DECODER \
    libOMX.TI.DUCATI1.VIDEO.DECODER.secure \
    libOMX.TI.DUCATI1.VIDEO.CAMERA \
    libOMX.TI.DUCATI1.MISC.SAMPLE \
    libstagefrighthw \
    libI420colorconvert \
    libtiutils \
    libion_ti \
    smc_pa_ctrl \
    tf_daemon \
    libtf_crypto_sst \
    hwcomposer.omap4 \
    libion.so \
    pvrsrvinit \
    libPVRScopeServices.so \
    libcorkscrew \
    libtee_client_api_driver

    LOCAL_DISABLE_PTHREAD := \
      libc_netbsd

    # -O3 flags and friends
    O3_FLAGS := \
      -O3 \
      -Wno-error=array-bounds \
      -Wno-error=strict-overflow
  else
    OPT2:=

  endif

  ifeq ($(strip $(ENABLE_PTHREAD)),true)
    OPT3 := (pthread)
  else
    OPT3:=
  endif
else
  $(warning ********************************************************************************)
  $(warning *  SaberMod currently only works on linux host systems.)
  $(warning ********************************************************************************)
endif
