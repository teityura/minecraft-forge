#!/bin/sh

XMS_SIZE=${1:-4096} # ヒープ領域の初期サイズを指定
XMX_SIZE=${2:-8192} # ヒープ領域の最大サイズを指定

# eula.txt を作成
test -e ./eula.txt || echo 'eula=true' > ./eula.txt

# カレントディレクトリ: /var/server-contents
# /forge-start.sh から /forges/minecraft_server.1.12.2.jar を実行して、
# /var/server-contents に マイクラサーバのデータを展開する
java -Xms${XMS_SIZE}M -Xmx${XMX_SIZE}M -jar /forges/forge-1.12.2-14.23.5.2855.jar nogui

exit 0
