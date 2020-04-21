#!/bin/bash
set -x
API=21
CPU=armv7-a
#so库输出目录
OUTPUT=./android/$CPU
# NDK的路径，根据自己的安装位置进行设置
NDK=/Users/pro/Library/Android/sdk/ndk/android-ndk-r16b
# 库文件
SYSROOT=$NDK/platforms/android-$API/arch-arm
# 头文件
ISYSROOT=$NDK/sysroot/usr/include
# 汇编头文件
ASM=$ISYSROOT/arm-linux-androideabi
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64

function build
{
./configure \
  --prefix=$OUTPUT \
  --target-os=android \
  --arch=arm \
  --cpu=armv7-a \
  --enable-asm \
  --enable-cross-compile \
  --enable-shared \
  --disable-static \
  --disable-doc \
  --disable-ffplay \
  --disable-ffprobe \
  --disable-symver \
  --disable-ffmpeg \
  --sysroot=$SYSROOT \
  --cc=$TOOLCHAIN/bin/arm-linux-androideabi-gcc \
  --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
  --extra-cflags="-I$ISYSROOT -I$ASM -fPIC"

make clean all
# 这里是定义用几个CPU编译
make -j8
make
make install
}
build