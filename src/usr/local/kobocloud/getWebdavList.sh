#!/bin/sh

davServer="$1"

#load config
. $(dirname $0)/config.sh

echo '<?xml version="1.0"?>
<a:propfind xmlns:a="DAV:">
<a:prop><a:resourcetype/></a:prop>
</a:propfind>' |
$CURL -k --silent -i -X PROPFIND $davServer --upload-file - -H "Depth: infinity" | # get the listing
grep -Eo '<D:href>[^<]*[^/]</D:href>' | # get the links without the folders
sed 's@</*D:href>@@g'
