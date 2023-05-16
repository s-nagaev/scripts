#!/bin/bash

cd "$(dirname "$0")" || exit 1


while getopts v:s: flag
do
    case "${flag}" in
        v) volume=${OPTARG};;
        s) source=${OPTARG};;
    esac
done


filename=$(basename "${source}")
cp ${source} /tmp/${filename}


docker volume create ${volume}
docker run --rm -v ${volume}:/data -v /tmp:/backup busybox tar -xzvf /backup/${filename} -C /data

rm /tmp/${filename}

