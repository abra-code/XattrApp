#!/bin/sh

source "$OMC_APP_BUNDLE_PATH/Contents/Resources/Scripts/xattr.library.sh"

echo "[$(/usr/bin/basename "$0")]"

add_button_tag="2"
remove_button_tag="3"
view_button_tag="4"

echo "OMC_CURRENT_COMMAND_GUID: ${OMC_CURRENT_COMMAND_GUID}"
echo "OMC_NIB_DLG_GUID: ${OMC_NIB_DLG_GUID}"
echo "OMC_NIB_TABLE_1_COLUMN_1_VALUE: $OMC_NIB_TABLE_1_COLUMN_1_VALUE"

if [ -n "$OMC_NIB_TABLE_1_COLUMN_1_VALUE" ]; then
	"$dialog" "$OMC_NIB_DLG_GUID" $remove_button_tag omc_enable
	"$dialog" "$OMC_NIB_DLG_GUID" $view_button_tag omc_enable
else
	"$dialog" "$OMC_NIB_DLG_GUID" $remove_button_tag omc_disable
	"$dialog" "$OMC_NIB_DLG_GUID" $view_button_tag omc_disable
fi
