#!/bin/sh

echo "[$(/usr/bin/basename "$0")]"

# this handler is called when the Open menu item is selected
if [ -n "$OMC_DLG_CHOOSE_OBJECT_PATH" ]; then
	"$OMC_OMC_SUPPORT_PATH/pasteboard" "XATTR_OBJECT_PATH" put "$OMC_DLG_CHOOSE_OBJECT_PATH";
	"$OMC_OMC_SUPPORT_PATH/omc_next_command" "$OMC_CURRENT_COMMAND_GUID" "xattr.new"
fi
