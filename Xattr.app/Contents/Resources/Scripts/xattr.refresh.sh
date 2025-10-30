#!/bin/sh

source "$OMC_APP_BUNDLE_PATH/Contents/Resources/Scripts/xattr.library.sh"

echo "[$(/usr/bin/basename "$0")]"
echo "OMC_CURRENT_COMMAND_GUID: ${OMC_CURRENT_COMMAND_GUID}"
echo "OMC_NIB_DLG_GUID: ${OMC_NIB_DLG_GUID}"

xattr_object_path="$OMC_NIB_DIALOG_CONTROL_5_VALUE"
echo "file path:\t${xattr_object_path}"

"$dialog" "$OMC_NIB_DLG_GUID" 1 omc_table_remove_all_rows
load_attribute_table "$OMC_NIB_DLG_GUID" "${xattr_object_path}"
