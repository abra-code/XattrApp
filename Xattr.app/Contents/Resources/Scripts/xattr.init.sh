#!/bin/sh

source "$OMC_APP_BUNDLE_PATH/Contents/Resources/Scripts/xattr.library.sh"

echo "[$(/usr/bin/basename "$0")]"
echo "OMC_CURRENT_COMMAND_GUID: ${OMC_CURRENT_COMMAND_GUID}"
echo "OMC_NIB_DLG_GUID: ${OMC_NIB_DLG_GUID}"

XATTR_OBJECT_PATH=""
if [ -n "$OMC_OBJ_PATH" ]; then
	# from objected dropped on app
	XATTR_OBJECT_PATH="$OMC_OBJ_PATH"
else
	# from navigation services open dialog
	XATTR_OBJECT_PATH=$("$pasteboard" "XATTR_OBJECT_PATH" get);
	"$pasteboard" "XATTR_OBJECT_PATH" set ""
fi

if [ -z "$XATTR_OBJECT_PATH" ]; then
	exit 1
fi

echo "XATTR_OBJECT_PATH = $XATTR_OBJECT_PATH"
# "$dialog" "$OMC_NIB_DLG_GUID" omc_window omc_invoke 'setTitleWithRepresentedFilename:' "$XATTR_OBJECT_PATH"
# hidden label control storing the path associated with the window:
"$dialog" "$OMC_NIB_DLG_GUID" 5 "$XATTR_OBJECT_PATH"

"$dialog" "$OMC_NIB_DLG_GUID" 1 omc_table_set_columns "Attribute Name" "Attribute Data"
"$dialog" "$OMC_NIB_DLG_GUID" 1 omc_table_set_column_widths 300 540

load_attribute_table "$OMC_NIB_DLG_GUID" "$XATTR_OBJECT_PATH"

"$next_command" "$OMC_CURRENT_COMMAND_GUID" "xattr.update.controls"
