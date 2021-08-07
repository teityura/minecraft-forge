# Minecraft-Forge on Docker

## git clone

```
mkdir -p ~/containers/
cd ~/containers/
git clone https://github.com/teityura/minecraft-forge.git
cd minecraft-forge/
```

## マイクラコンテナを起動

特に何も編集せずに `docker-compose up -d` 動作可能

```
docker-compose up -d
docker-compose exec minecraft-server ps aux
docker-compose logs -f
```

## MODを追加する場合

```
vim mods-downloader/mods.csv

project_url,mod_url,mod_name
https://www.curseforge.com/minecraft/mc-mods/buildcraft,https://media.forgecdn.net/files/3204/475/buildcraft-all-7.99.24.8.jar,buildcraft-all-7.99.24.8.jar
```

## forgeのヒープ領域のサイズを変更

.envを適宜変更 (単位はMB)

- XMS_SIZE (ヒープ領域の初期サイズ)
- XMX_SIZE (ヒープ領域の最大サイズ)

```
vim .env

XMS_SIZE=4096
XMX_SIZE=8192
```

## セーブデータをバックアップする場合

スクリプトでアーカイブを作成してバックアップする  
./create-archive.sh [archiving_dir] [save_location]  
`スクリプトの引数は絶対パスで渡す(重要)`

```
# マイクラコンテナを一度止める(念のため)
docker-compose down

# スクリプトを実行して、アーカイブを作成する
~/containers/minecraft-forge/savedata-manager/create-archive.sh \
  ~/containers/minecraft-forge/minecraft-server/server-contents/ \
  ~/containers/minecraft-forge/savedata-manager/savedata-archives/

# savedata-archives/savedata-20210602021441.tar.gz みたいなのができる
```

## 既存のセーブデータで起動する場合

1. アーカイブを作成する

`savedata-20YYmmddHHMMSS.tar.gz の書式で保存する(重要)`

```
# tarコマンドを実行する
tar cvzf "savedata-`date '+%Y%m%d%H%M%S'`.tar.gz" \
  world{,_nether,_the_end}/ banned-{ips,players}.json server.properties ops.json whitelist.json

# savedata-20210602021441.tar.gz みたいなのができる
# tar.gz の中身を確認する場合、下記コマンドを実行する
# tar --exclude='*/*' -tf savedata-20210602021441.tar.gz
```

2. アーカイブを配置する

```
# scp など使って、以下のように配置する
scp savedata-20210602021441.tar.gz \
  docker-host:/root/containers/minecraft-forge/savedata-manager/savedata-archives/

# 下記のように配置できていればOK
# ~/containers/minecraft-forge/savedata-manager/savedata-archives/savedata-20210602021441.tar.gz
```

3. アーカイブを展開して、マイクラコンテナを起動する

```
docker-compose down
docker-compose -f savedata-manager.yml up -d
docker-compose -f savedata-manager.yml logs -f
```

4. セーブデータ移行後は、普段通りに起動する

```
docker-compose -f savedata-manager.yml down
docker-compose up -d
```
