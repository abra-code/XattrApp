#!/bin/sh

# echo "xattr.view.sh"

source "$OMC_APP_BUNDLE_PATH/Contents/Resources/Scripts/xattr.library.sh"

# echo "[$(/usr/bin/basename "$0")]"

getxattr="$OMC_APP_BUNDLE_PATH/Contents/MacOS/getxattr"
# echo "getxattr: $getxattr"

echo ""

xattr_object_path="$OMC_NIB_DIALOG_CONTROL_5_VALUE"
echo "file path:\t${xattr_object_path}"

attribute_name="$OMC_NIB_TABLE_1_COLUMN_1_VALUE"
echo "attribute:\t${attribute_name}"

if [ -z "${attribute_name}" ]; then
	exit 1
fi

/bin/mkdir -p "/tmp/xattr"
temp_attribute_data_path="/tmp/xattr/temp-$OMC_NIB_DLG_GUID.data"

# dump the attribute data into temp file with the getxattr helper tool
"$getxattr" "${xattr_object_path}" "${attribute_name}" "${temp_attribute_data_path}"


data_type=$(/usr/bin/file --brief "${temp_attribute_data_path}")
echo "data type:\t${data_type}"

echo ""

is_non_standard_text=$(echo "${data_type}" | /usr/bin/grep -E -e "Non-ISO")
if [ -z "${is_non_standard_text}" ]; then
	is_text_format=$(echo "${data_type}" | /usr/bin/grep -E -e "ASCII text" -e "us-ascii" -e "UTF-8" -e "utf-8")
	if [ -n "${is_text_format}" ]; then
	# 	echo "Found ASCII"
		cat "${temp_attribute_data_path}"
		exit 0
	fi
fi

is_bplist_format=$(echo "${data_type}" | /usr/bin/grep "binary property list")
if [ -n "${is_bplist_format}" ]; then
# 	echo "Found bplist"
	/usr/bin/plutil -convert xml1 "${temp_attribute_data_path}" 2>/dev/null
	err=$?
	if [ "${err}" = "0" ]; then
		/bin/cat "${temp_attribute_data_path}"
		exit 0
	fi
fi

is_json_format=$(echo "${data_type}" | /usr/bin/grep "JSON data")
if [ -n "${is_json_format}" ]; then
# 	echo "Found JSON"
	cat "${temp_attribute_data_path}"
	exit 0
fi

iconv_format=""
is_utf32_text=$(echo "${data_type}" | /usr/bin/grep -E -e "UTF-32" -e "utf-32")
if [ -n "${is_utf32_text}" ]; then
	iconv_format="UTF-32"
fi

is_utf16_text=$(echo "${data_type}" | /usr/bin/grep -E -e "UTF-16" -e "utf-16")
if [ -n "${is_utf16_text}" ]; then
	iconv_format="UTF-16"
fi

is_utf7_text=$(echo "${data_type}" | /usr/bin/grep -E -e "UTF-7" -e "utf-7")
if [ -n "${is_utf7_text}" ]; then
	iconv_format="UTF-7"
fi

if [ -n "${iconv_format}" ]; then
	 /usr/bin/iconv -f "${iconv_format}" -t "UTF-8" "${temp_attribute_data_path}"
	 exit 0
fi

# echo "Found binary data"
/usr/bin/xxd "${temp_attribute_data_path}"

/bin/rm -f "${temp_attribute_data_path}"
