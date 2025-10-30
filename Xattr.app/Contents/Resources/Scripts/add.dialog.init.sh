#!/bin/sh

echo "[$(/usr/bin/basename "$0")]"

source "$OMC_APP_BUNDLE_PATH/Contents/Resources/Scripts/xattr.library.sh"

# stored in private pasteboard by parent dialog in 'xattr.add.sh' before creating this dialog
XATTR_OBJECT_PATH=$("$pasteboard" "XATTR_OBJECT_PATH" get)
echo "XATTR_OBJECT_PATH: ${XATTR_OBJECT_PATH}"
"$pasteboard" "XATTR_OBJECT_PATH" set ""

XATTR_PARENT_DIALOG_GUID=$("$pasteboard" "XATTR_PARENT_DIALOG_GUID" get)
echo "XATTR_PARENT_DIALOG_GUID: ${XATTR_PARENT_DIALOG_GUID}"
"$pasteboard" "XATTR_PARENT_DIALOG_GUID" set ""

# hidden label control storing the object path:
"$dialog" "$OMC_NIB_DLG_GUID" 3 "$XATTR_OBJECT_PATH"

# hidden label control storing parent dialog GUID:
"$dialog" "$OMC_NIB_DLG_GUID" 4 "$XATTR_PARENT_DIALOG_GUID"
