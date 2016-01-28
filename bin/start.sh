#!/bin/bash

PROJECT=$(pwd)
if [ -f "${PROJECT}/logs/nginx.pid" ]; then   
    echo "static-server is already running."
else
    echo "starting static-server ... "
    # 生成nginx配置文件
    if [ ! -f "${PROJECT}/conf/nginx.conf" ]; then 
        rm "${PROJECT}/conf/nginx.conf"
    fi 

    #cp ${PROJECT}/conf/nginx.conf.tpl ${PROJECT}/conf/nginx.conf
    sed "s:{PROJECT}:${PROJECT}:g" ${PROJECT}/conf/nginx.conf.tpl > ${PROJECT}/conf/nginx.conf

    # 启动配置文件
    ./bin/nginx -c ${PROJECT}/conf/nginx.conf
fi
