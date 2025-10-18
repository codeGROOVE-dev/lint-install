#!/bin/sh
# Test script with intentional shellcheck issues

# SC2006: Use $() instead of backticks
result=`echo "hello"`

# SC2086: Double quote to prevent globbing
echo $result

# SC2164: Use cd ... || exit in case cd fails
cd /tmp

# SC2034: unused variable
unused_var="never used"
