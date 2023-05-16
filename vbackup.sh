#!/bin/bash

cd "$(dirname "$0")" || exit 1


while getopts v:o: flag
do
    case "${flag}" in
        v) volume=${OPTARG};;
        o) output=${OPTARG};;
    esac
done


if [ -z ${output} ]; then
  file_name=${volume}
  full_file_name="${file_name}.tar.gz"
else
  file_name=$(basename "${output}")
  full_file_name="${output}.tar.gz"
fi


echo "===================================="
echo $file_name
echo $full_file_name
echo "===================================="


docker run --rm -v ${volume}:/data -v /tmp:/backup busybox tar -czvf /backup/${file_name}.tar.gz -C / data/ >> /dev/null

mv /tmp/${file_name}.tar.gz ${full_file_name}

