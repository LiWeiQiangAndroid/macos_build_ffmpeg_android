#!/bin/bash
set -x
# 目标Android版本
API=21
CPU=armv7-a
#so库输出目录
OUTPUT=./android/$CPU
# NDK的路径，根据自己的NDK位置进行设置
NDK=/Users/pro/Library/Android/sdk/ndk/android-ndk-r20b
# 编译工具链路径
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
# 编译环境
SYSROOT=$TOOLCHAIN/sysroot

function build
{
  ./configure \
  --prefix=$OUTPUT \
  --target-os=android \
  --arch=arm \
  --cpu=armv7-a \
  --enable-asm \
  --enable-neon \
  --enable-cross-compile \
  --enable-shared \
  --disable-static \
  --disable-doc \
  --disable-ffplay \
  --disable-ffprobe \
  --disable-symver \
  --disable-ffmpeg \
  --sysroot=$SYSROOT \
  --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
  --cross-prefix-clang=$TOOLCHAIN/bin/armv7a-linux-androideabi$API- \
  --extra-cflags="-fPIC"

  make clean all
  # 这里是定义用几个CPU编译
  make -j4
  make install
}

build