#!/bin/bash

#你的NDK路径
NDK=/Users/pro/Library/Android/sdk/ndk/android-ndk-r20b
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
API=21

echo "进入FFmpeg编译脚本"

COMMON_OPTIONS="\
    --enable-shared \
    --disable-static \
    --enable-jni \
    --disable-doc \
    --disable-symver \
    --disable-programs \
    --target-os=android \
    --disable-asm \
    --enable-cross-compile
    "

function build_android
{
echo "开始编译FFmpeg(armeabi-v7a)"
source "config-env.sh"
OUTPUT_FOLDER="armeabi-v7a"
ARCH="arm"
CPU="armv7-a"
TOOL_CPU_NAME=armv7a
TOOL_PREFIX="$TOOLCHAIN/bin/arm-linux-androideabi"

CC="$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang"
CXX="$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang++"
SYSROOT="$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot"
PREFIX="${PWD}/android/$OUTPUT_FOLDER"
LIB_DIR="${PWD}/android/libs/$OUTPUT_FOLDER"
OPTIMIZE_CFLAGS="-march=$CPU"
./configure \
    --prefix=$PREFIX \
    --libdir=$LIB_DIR \
    --arch=$ARCH \
    --cpu=$CPU \
    --cc=$CC \
    --cxx=$CXX \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $COMMON_OPTIONS \
    $COMMON_FF_CFG_FLAGS
make clean
make -j8
make install
echo "The Compilation of FFmpeg for $CPU is completed"
echo "FFmpeg $CPU 编译完成"

##################################################################
echo "开始编译FFmpeg(arm64-v8a)"
source "config-env.sh"
OUTPUT_FOLDER="arm64-v8a"
ARCH=arm64
CPU="armv8-a"
TOOL_CPU_NAME=aarch64
TOOL_PREFIX="$TOOLCHAIN/bin/$TOOL_CPU_NAME-linux-android"

CC="$TOOL_PREFIX$API-clang"
CXX="$TOOL_PREFIX$API-clang++"
SYSROOT="$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot"
PREFIX="${PWD}/android/$OUTPUT_FOLDER"
LIB_DIR="${PWD}/android/libs/$OUTPUT_FOLDER"
OPTIMIZE_CFLAGS="-march=$CPU"
./configure \
    --prefix=$PREFIX \
    --libdir=$LIB_DIR \
    --arch=$ARCH \
    --cpu=$CPU \
    --cc=$CC \
    --cxx=$CXX \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $COMMON_OPTIONS \
    $COMMON_FF_CFG_FLAGS
make clean
make -j8
make install
echo "The Compilation of FFmpeg for $CPU is completed"
echo "FFmpeg $CPU 编译完成"
#################################################################


echo "开始编译FFmpeg(x86)"
source "config-env.sh"
OUTPUT_FOLDER="x86"
ARCH="x86"
CPU="x86"
TOOL_CPU_NAME="i686"
TOOL_PREFIX="$TOOLCHAIN/bin/${TOOL_CPU_NAME}-linux-android"

CC="$TOOL_PREFIX$API-clang"
CXX="$TOOL_PREFIX$API-clang++"
SYSROOT="$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot"
PREFIX="${PWD}/android/$OUTPUT_FOLDER"
LIB_DIR="${PWD}/android/libs/$OUTPUT_FOLDER"
OPTIMIZE_CFLAGS="-march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32"
./configure \
    --prefix=$PREFIX \
    --libdir=$LIB_DIR \
    --arch=$ARCH \
    --cpu=$CPU \
    --cc=$CC \
    --cxx=$CXX \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $COMMON_OPTIONS \
    $COMMON_FF_CFG_FLAGS
make clean
make -j8
make install
echo "The Compilation of FFmpeg for $CPU is completed"
echo "FFmpeg $CPU 编译完成"
#############################################################

echo "开始编译FFmpeg(x86_64)"
source "config-env.sh"
OUTPUT_FOLDER="x86_64"
ARCH="x86_64"
CPU="x86-64"
TOOL_CPU_NAME="x86_64"
TOOL_PREFIX="$TOOLCHAIN/bin/${TOOL_CPU_NAME}-linux-android"

CC="$TOOL_PREFIX$API-clang"
CXX="$TOOL_PREFIX$API-clang++"
SYSROOT="$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot"
PREFIX="${PWD}/android/$OUTPUT_FOLDER"
LIB_DIR="${PWD}/android/libs/$OUTPUT_FOLDER"
OPTIMIZE_CFLAGS="-march=$CPU"
./configure \
    --prefix=$PREFIX \
    --libdir=$LIB_DIR \
    --arch=$ARCH \
    --cpu=$CPU \
    --cc=$CC \
    --cxx=$CXX \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $COMMON_OPTIONS \
    $COMMON_FF_CFG_FLAGS
make clean
make -j8
make install
echo "The Compilation of FFmpeg for $CPU is completed"
echo "FFmpeg $CPU 编译完成"
echo "FFmpeg 所有so架构 编译完成"
}

build_android