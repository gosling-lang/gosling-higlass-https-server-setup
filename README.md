# gosling-higlass-https-server-setup

### Adding Tilesets
Reference: https://github.com/higlass/higlass-docker

#### Download a tileset data to add
```sh
$ sudo wget -P /data/hg-tmp/
```

#### Confirm that a tileset is visible in Docker
```sh
$ sudo docker exec higlass-container ls /tmp

Cistrome.H3K27ac.ChIP-seq.multires.mv5
...
```

#### Ingest a tileset:
```sh
$ sudo docker exec higlass-container python higlass-server/manage.py ingest_tileset \
      --filename /tmp/Cistrome.H3K27ac.ChIP-seq.multires.mv5 \
      --filetype multivec \
      --datatype multivec \
      --project-name "gosling-data-v1" \
      --uid cistrome.multivec
```
