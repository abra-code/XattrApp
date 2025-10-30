#!/bin/sh

source "$OMC_APP_BUNDLE_PATH/Contents/Resources/Scripts/xattr.library.sh"

echo "[$(/usr/bin/basename "$0")]"

xattr_object_path="$OMC_NIB_DIALOG_CONTROL_5_VALUE"
# echo "file path:\t${xattr_object_path}"

attribute_name="$OMC_NIB_TABLE_1_COLUMN_1_VALUE"
# echo "attribute:\t${attribute_name}"

if [ -z "${attribute_name}" ]; then
	exit 1
fi

/usr/bin/xattr -d "${attribute_name}" "${xattr_object_path}"

"$dialog" "$OMC_NIB_DLG_GUID" 1 omc_table_remove_all_rows

load_attribute_table "$OMC_NIB_DLG_GUID" "${xattr_object_path}"
