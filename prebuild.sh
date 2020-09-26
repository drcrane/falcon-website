#!/bin/sh
set -o errexit
set -o nounset

# Script to be executed before building the container
# it creates index.html from index.html.template and replaces
# @GITHASH@ and @GITCOMMITDATE@ with the GITHASH and 
# GITCOMMITDATE... surprisingly.

GITHASH="$(git log -1 --pretty="format:%h")"
GITCOMMITDATE="$(git log -1 --pretty="format:%ci")"
for TEMPLATEFILE in src/*.template.html ; do
	OUTPUTFILE="$(echo ${TEMPLATEFILE}|sed 's/^[^\/]*\/\(.*\)\.template\.html$/htdocs\/\1.html/')"
	sed -e 's/@GITHASH@/'"${GITHASH}"'/g' -e 's/@GITCOMMITDATE@/'"${GITCOMMITDATE}"'/g' "${TEMPLATEFILE}" > "${OUTPUTFILE}"
done

