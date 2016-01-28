#!/bin/bash
PROJECT=$(pwd)
if [ -f "${PROJECT}/logs/nginx.pid" ] 
then  
    pid=$(cat ${PROJECT}/logs/nginx.pid)
    kill -QUIT ${pid}
    rm ${PROJECT}/logs/nginx.pid
    echo "static-server stopped."
else 
    echo "static-server not running."
fi
