#!/usr/bin/env bash
set -e
set -v

# DOCKER_VERSION is the version of higlass/higlass-docker
# docker pull higlass/higlass-docker:v0.6.51
DOCKER_VERSION=v0.6.51
IMAGE=higlass/higlass-docker:$DOCKER_VERSION
PORT=80
FILE_VERSION=20200814

# stop and remove container, if it exists
docker stop higlass-container || true && docker rm higlass-container || true

# remove previously ingested data
rm -f ~/hg-data/db.sqlite3
rm -rf ~/hg-data/media ~/hg-data/media

docker run --name higlass-container \
           --publish $PORT:80 \
           --volume ~/hg-data:/data \
           --volume ~/hg-tmp:/tmp \
           --detach \
           $IMAGE

# We have to wait to make sure the container is properly running
sleep 2

# Add tilesets here

# Example: 
# docker exec higlass-container python higlass-server/manage.py ingest_tileset \
#            --filename /data/hg38_full.txt \
#            --filetype chromsizes-tsv \
#            --datatype chromsizes \
#            --coordSystem hg38 \
#            --uid chromsizes_hg38
