#!/bin/bash
set -e
clean="rm -rf $BUILD_DIR $INSTALL_DIR"
#echo "Running $clean"
#sleep 5s

echo "Will run:"
echo "    $clean"

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Aborting"
    exit 1
fi

set -x
$clean
