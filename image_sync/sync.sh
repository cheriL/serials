#!/bin/bash

set -e

IMAGE_LIST_FILE="images.txt"
TARGET="registry/project"

# 读取镜像列表文件
if [ ! -f "$IMAGE_LIST_FILE" ]; then
  echo "镜像列表文件 $IMAGE_LIST_FILE 不存在"
  exit 1
fi

while IFS= read -r IMAGE; do
  if [ -n "$IMAGE" ]; then
    echo "Pulling $IMAGE..."
    docker pull "$IMAGE"

    IMAGE_NAME=$(echo "$IMAGE" | cut -d: -f1)
    IMAGE_TAG=$(echo "$IMAGE" | cut -d: -f2)
    BASE_NAME=$(echo "$IMAGE_NAME" | awk -F/ '{print $(NF)}')
    NEW_IMAGE="$TARGET/$BASE_NAME:$IMAGE_TAG"
    echo "Tagging $IMAGE as $NEW_IMAGE"
    docker tag "$IMAGE" "$NEW_IMAGE"

    # 推送到新仓库
    echo "Pushing $NEW_IMAGE..."
    docker push "$NEW_IMAGE"

    # 可选：删除本地新标签的镜像
    docker rmi "$NEW_IMAGE"
    docker rmi "$IMAGE"
  fi
done < "$IMAGE_LIST_FILE"