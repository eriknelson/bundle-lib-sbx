#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MOUNT_SRC=$GOPATH/src/github.com/automationbroker/bundle-lib
MOUNT_DEST=${_dir}/vendor/github.com/automationbroker/bundle-lib
mkdir -p $MOUNT_DEST

echo "MOUNT_SRC: $MOUNT_SRC"
echo "MOUNT_DEST: $MOUNT_DEST"

bindfs -u ernelson -g ernelson --no-allow-other \
  $MOUNT_SRC $MOUNT_DEST
