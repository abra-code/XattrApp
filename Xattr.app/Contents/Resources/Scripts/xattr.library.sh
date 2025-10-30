#!/bin/sh

dialog="$OMC_OMC_SUPPORT_PATH/omc_dialog_control"
plister="$OMC_OMC_SUPPORT_PATH/plister"
filt="$OMC_OMC_SUPPORT_PATH/filt"
pasteboard="$OMC_OMC_SUPPORT_PATH/pasteboard"
next_command="$OMC_OMC_SUPPORT_PATH/omc_next_command"

load_attribute_table()
{
	local xattr_dialog_guid="$1"
	local xattr_object_path="$2"
	
	local all_attribute_names=$(/usr/bin/xattr "${xattr_object_path}")
	
	while read -r attribute_name; do
# 		echo "${attribute_name}"
		local printable_attribute_data=$(/usr/bin/xattr -p "${attribute_name}" "${xattr_object_path}" | /usr/bin/tr "\n" " " | /usr/bin/tr -c '[:print:]' '.')
		echo "${attribute_name}\t${printable_attribute_data}" | "$dialog" "$xattr_dialog_guid" 1 omc_table_add_rows_from_stdin
	done <<< "${all_attribute_names}"
}
