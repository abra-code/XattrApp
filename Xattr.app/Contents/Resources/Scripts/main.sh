#!/bin/sh

echo "[$(/usr/bin/basename "$0")]"
echo "OMC_CURRENT_COMMAND_GUID: ${OMC_CURRENT_COMMAND_GUID}"

next_command="$OMC_OMC_SUPPORT_PATH/omc_next_command"
if [ -n "$OMC_OBJ_PATH" ]; then
	# a file or folder dropped on the app icon
	"$next_command" "$OMC_CURRENT_COMMAND_GUID" "xattr.new"
else
	# launched without a dropped object, present a choose object dialog
	"$next_command" "$OMC_CURRENT_COMMAND_GUID" "xattr.open.from.file.browser"
fi
