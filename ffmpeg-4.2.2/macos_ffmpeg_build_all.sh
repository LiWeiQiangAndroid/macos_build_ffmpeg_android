#!/bin/bash

echo "进入FFmpeg编译脚本"
set -x
# 目标Android版本
API=21
 
# NDK的路径，根据自己的NDK位置进行设置
NDK=/Users/pro/Library/Android/sdk/ndk/android-ndk-r20b
# 编译工具链路径
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
# 编译环境
SYSROOT=$TOOLCHAIN/sysroot


COMMON_OPTIONS="\
    --target-os=android \
    --enable-asm \
    --enable-neon \
    --enable-cross-compile \
    --enable-shared \
    --disable-static \
    --enable-jni \
    --disable-doc \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-symver \
    --disable-programs \
    --disable-ffmpeg \
    --extra-cflags="-fPIC"
    "

function build_android {

    # echo "开始编译FFmpeg..."

    # # armeabi-v7a
    # echo "开始编译FFmpeg(armeabi-v7a)"
    # ./configure \
    # --prefix=./android/armeabi-v7a \
    # --arch=arm \
    # --cpu=armv7-a \
    # --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
    # --sysroot=$SYSROOT \
    # --cross-prefix-clang=$TOOLCHAIN/bin/armv7a-linux-androideabi$API- \
    # ${COMMON_OPTIONS}
    # make clean
    # make -j4 && make install
    # echo "结束编译FFmpeg(armeabi-v7a)"

    # arm64-v8a
    # echo "开始编译FFmpeg(arm64-v8a)"
    # ./configure \
    # --prefix=./android/arm64-v8a \
    # --arch=aarch64 \
    # --cpu=armv8-a \
    # --sysroot=$SYSROOT \
    # --cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
    # --cross-prefix-clang=$TOOLCHAIN/bin/aarch64-linux-android$API- \
    # ${COMMON_OPTIONS} 
    # make clean
    # make -j4 && make install
    # echo "结束编译FFmpeg(arm64-v8a)"

    # x86
    echo "开始编译FFmpeg(x86)"
    ./configure \
    --prefix=./android/x86 \
    --arch=x86 \
    --cpu=i686 \
    --sysroot=$SYSROOT \
    --cross-prefix=$TOOLCHAIN/bin/i686-linux-android- \
    --cross-prefix-clang=$TOOLCHAIN/bin/i686-linux-android$API- \
    --cxx=$TOOLCHAIN/bin/i686-linux-android$API-clang++ \
    --enable-cross-compile \
    --disable-asm \
    --disable-iconv \
    ${COMMON_OPTIONS} 
    make clean
    make -j4 && make install
    echo "结束编译FFmpeg(x86)"

    # x86_64
    # echo "开始编译FFmpeg(x86_64)"
    # ./configure \
    # --prefix=./android/x86_64 \
    # --arch=x86_64 \
    # --cpu=x86_64 \
    # --sysroot=$SYSROOT \
    # --cross-prefix=$TOOLCHAIN/bin/x86_64-linux-android- \
    # --cross-prefix-clang=$TOOLCHAIN/bin/x86_64-linux-android$API- \
    # ${COMMON_OPTIONS}
    # make clean
    # make -j4 && make install
    # echo "结束编译FFmpeg(x86_64)"

    echo "编译结束"

};
build_android