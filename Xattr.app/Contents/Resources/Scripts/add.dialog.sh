#!/bin/sh

echo "[$(/usr/bin/basename "$0")]"

# this is a modal dialog and this script executes only after user okeyed the dialog
source "$OMC_APP_BUNDLE_PATH/Contents/Resources/Scripts/xattr.library.sh"

# get values from hidden controls passed from parent dialog
XATTR_OBJECT_PATH="$OMC_NIB_DIALOG_CONTROL_3_VALUE"
XATTR_PARENT_DIALOG_GUID="$OMC_NIB_DIALOG_CONTROL_4_VALUE"
echo "XATTR_PARENT_DIALOG_GUID: ${XATTR_PARENT_DIALOG_GUID}"

attribute_name="$OMC_NIB_DIALOG_CONTROL_1_VALUE"
attribute_value="$OMC_NIB_DIALOG_CONTROL_2_VALUE"

/usr/bin/xattr -w "${attribute_name}" "${attribute_value}" "${XATTR_OBJECT_PATH}"

"$dialog" "$XATTR_PARENT_DIALOG_GUID" 1 omc_table_remove_all_rows
load_attribute_table "$XATTR_PARENT_DIALOG_GUID" "${XATTR_OBJECT_PATH}"
