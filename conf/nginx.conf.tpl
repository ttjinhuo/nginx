user  www www;
worker_processes  2;

error_log  {PROJECT}/logs/error.log;
#error_log  {PROJECT}/logs/error.log  notice;
#error_log  {PROJECT}/logs/error.log  info;

pid        {PROJECT}/logs/nginx.pid;


events {
    worker_connections  2048;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  {PROJECT}/logs/access.log  main;

    sendfile        on;
    # tcp_nopush     on;

    keepalive_timeout  65;

    # gzip压缩功能设置
    gzip on;
    gzip_min_length 1k;
    gzip_buffers    4 16k;
    gzip_http_version 1.0;
    gzip_comp_level 6;
    gzip_types text/html text/plain text/css text/javascript application/json application/javascript application/x-javascript application/xml;
    gzip_vary on;

    # http_proxy 设置
    client_max_body_size   10m;
    client_body_buffer_size   128k;
    proxy_connect_timeout   75;
    proxy_send_timeout   75;
    proxy_read_timeout   75;
    proxy_buffer_size   4k;
    proxy_buffers   4 32k;
    proxy_busy_buffers_size   64k;
    proxy_temp_file_write_size  64k;
    proxy_temp_path   {PROJECT}/proxy_temp 1 2;




    ## api-server 虚拟主机配置
    server{
        listen 80;
        server_name api.ttjinhuo.com;
        location / {
            proxy_redirect off;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://localhost:3001;
        }
        access_log {PROJECT}/logs/api.ttjinhuo.com_access.log;
    }

    ## oauth2-server 虚拟主机配置
    server{
        listen 80;
        server_name oauth2.ttjinhuo.com;
        location / {
            proxy_redirect off;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://localhost:3002;
        }
        access_log {PROJECT}/logs/oauth.ttjinhuo.com_access.log;
    }

    ## www.ttjinhuo.com 虚拟主机配置
    server{
        listen 80;
        server_name www.ttjinhuo.com ttjinhuo.com;
        location / {
            proxy_redirect off;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://localhost:3003;
        }
        access_log {PROJECT}/logs/www.ttjinhuo.com_access.log;
    }

    ## adminEx-server 虚拟主机配置
    server{
        listen 80;
        server_name admin.ttjinhuo.com;
        location / {
            proxy_redirect off;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://localhost:3004;
        }
        access_log {PROJECT}/logs/admin.ttjinhuo.com_access.log;
    }
}
