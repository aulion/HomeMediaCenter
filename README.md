# HomeMediaCenter


## Build

    cd nginx-1.10.1
    ./configure --add-module=../nginx_mod_h264_streaming-2.2.7 --with-pcre=../pcre-8.39
    make

## Install

    make install