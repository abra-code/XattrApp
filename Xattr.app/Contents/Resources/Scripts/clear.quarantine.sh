#!/bin/sh

echo "[$(/usr/bin/basename "$0")]"

echo "/usr/bin/xattr -r -d 'com.apple.quarantine' ${OMC_OBJ_PATH}"
/usr/bin/xattr -r -d 'com.apple.quarantine' "${OMC_OBJ_PATH}"
xattr_result=$?
echo "xattr result: $xattr_result"
