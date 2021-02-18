# gosling-higlass-https-server-setup
This repository describes a way to setup a HTTPS HiGlass server using a free Let's Encrypt service. This allows to fetch tiles from a HiGlass server (e.g., https://server.gosling-lang.org) in HTTPS clients (e.g., https://gosling.js.org). Because of the security issue, you cannot fetch tiles if the server is not HTTPS server but the client is HTTPS.

### Setup
Reference: https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71

#### Place a nginx config file to a certain directory:
```sh
$ mv hgserver_nginx.conf webcontext/sites-enabled/hgserver_nginx.conf
$ ls
init-letsencrypt.sh     docker-compose.yml      web-context
```

#### Run `init-letsencrypt.sh`
This will run `certbot` which will validate your site and give certificates for HTTPS.
```sh
./init-letsencrypt.sh
```

If you recived a "success" message, you are all set!

Let's start the server
```sh
docker-compose up
```

### Adding Tilesets
Reference: https://github.com/higlass/higlass-docker

#### Download a tileset data to add
```sh
$ sudo wget -P /data/hg-tmp/ http://YOUR_LINK.COM
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
      --uid cistrome.multivec \
      --coordSystem hg38
```
