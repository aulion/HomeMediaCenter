# HomeMediaCenter


## Build

    cd nginx-1.10.1
    ./configure --add-module=../nginx_mod_h264_streaming-2.2.7 --with-pcre=../pcre-8.39
    make

## Install
    * More detail see README in nginx
    * In nginx directory
    make install

    

## Configuration

    *Edit the configuration file so that file requests ending in ".mp4" are handled by the 'mp4' command.

    *    nginx.conf

        location ~ \.mp4$ {
            mp4;
        }


