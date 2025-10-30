#!/bin/sh

echo "[$(/usr/bin/basename "$0")]"

source "$OMC_APP_BUNDLE_PATH/Contents/Resources/Scripts/xattr.library.sh"

# echo "OMC_NIB_DIALOG_CONTROL_5_VALUE: ${OMC_NIB_DIALOG_CONTROL_5_VALUE}"
"$pasteboard" "XATTR_OBJECT_PATH" put "${OMC_NIB_DIALOG_CONTROL_5_VALUE}"

"$pasteboard" "XATTR_PARENT_DIALOG_GUID" put "${OMC_NIB_DLG_GUID}"
# echo "OMC_NIB_DLG_GUID: ${OMC_NIB_DLG_GUID}"

"$next_command" "$OMC_CURRENT_COMMAND_GUID" "add.dialog"
