
#export PKG_CONFIG_PATH=/home/jianjun/workspace/protobuf/build/install/usr/protobuf-3.5.1-x86_64/lib/pkgconfig/:$PKG_CONFIG_PATH

THIRDPARTY_PATH="$(pwd)/3rdparty"

FFMPEG_PATH=${THIRDPARTY_PATH}/ffmpeg-4.2.2/

FF_CFLAGS="-I${FFMPEG_PATH}/include/"
FF_LIBS="-L${FFMPEG_PATH}/lib/ -lavcodec -lavformat -lavfilter -lavutil -lswresample -lswscale"

export AVCODEC_CFLAGS="${FF_CFLAGS}"
export AVCODEC_LIBS="${FF_LIBS}"

export AVFORMAT_CFLAGS="${FF_CFLAGS}"
export AVFORMAT_LIBS="${FF_LIBS}"

#export AVAHI_CFLAGS="${FF_CFLAGS}"
#export AVAHI_LIBS="${FF_LIBS}"

export SWSCALE_CFLAGS="${FF_CFLAGS}"
export SWSCALE_LIBS="${FF_LIBS}"


export PROTOC=${THIRDPARTY_PATH}/protobuf-3.5.1-x86_64/bin/protoc
export CHROMECAST_CFLAGS="-I${THIRDPARTY_PATH}/protobuf-3.5.1-x86_64/include"
export CHROMECAST_LIBS=${THIRDPARTY_PATH}/protobuf-3.5.1-x86_64/lib/libprotobuf.so

export PKG_CONFIG_PATH=/opt/Qt5.9.9/5.9.9/gcc_64/lib/pkgconfig/:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=${THIRDPARTY_PATH}/x264-master/install/lib/pkgconfig/:$PKG_CONFIG_PATH

CC=gcc-5  CXX=g++-5 ./configure --disable-lua --disable-a52 --disable-chromecast --disable-opencv --prefix=`pwd`/install
