#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BUNDLE_LIB_MOUNT_SRC=$GOPATH/src/github.com/automationbroker/bundle-lib
BUNDLE_LIB_MOUNT_DEST=${_dir}/vendor/github.com/automationbroker/bundle-lib

BROKER_CLIENT_GO_MOUNT_SRC=$GOPATH/src/github.com/automationbroker/broker-client-go
BROKER_CLIENT_GO_MOUNT_DEST=${_dir}/vendor/github.com/automationbroker/broker-client-go

umount -R $BUNDLE_LIB_MOUNT_DEST
umount -R $BROKER_CLIENT_GO_MOUNT_DEST

mkdir -p $BUNDLE_LIB_MOUNT_DEST
mkdir -p $BROKER_CLIENT_GO_MOUNT_DEST

bindfs -u ernelson -g ernelson --no-allow-other \
  $MOUNT_SRC $MOUNT_DEST
bindfs -u ernelson -g ernelson --no-allow-other \
  $BROKER_CLIENT_GO_MOUNT_SRC $BROKER_CLIENT_GO_MOUNT_DEST
