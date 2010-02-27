#!/bin/bash

ORIGFILE="$1"

is_relative() {
    local path="$1"
    shift

    [ "${path:0:1}" != "/" ]
    return
}

set_offsets() {
	# This won't work with non-GNU stat.
	FILE_SIZE=`stat -L --format "%s" "$1"`
	local offset=$(($FILE_SIZE - 4))
	
	MAGIC_OFFSET=$offset
	offset=$(($offset - 4))
	
	CHECKSUM_OFFSET=$offset
	offset=$(($offset - 4))
	
	VERSION_OFFSET=$offset
	offset=$(($offset - 4))
	
	PREPAYLOAD_OFFSET=$offset
	offset=$(($offset - 4))
	
	PREPAYLOAD_SIZE_OFFSET=$offset
	offset=$(($offset - 4))
	
	LAUNCHER_SIZE_OFFSET=$offset
	offset=$(($offset - 4))
	
	PAYLOAD_OFFSET=$offset
	offset=$(($offset - 4))
	
	PAYLOAD_SIZE_OFFSET=$offset
	offset=$(($offset - 4))
}

set_lengths() {
   local file="$1"
   if [ ! -s "$file" ]; then
      echo "$file does not exist"
      exit 1
   fi

   # XXX: put extraction in its own function
   MAGIC_NUMBER=`od -An -t u4 -N 4 -j $MAGIC_OFFSET "$file" | tr -d ' '`

   if [ "$MAGIC_NUMBER" != "907380241" ]; then
      echo "magic number does not match"
      exit 1
   fi

   LAUNCHER_SIZE=`od -An -t u4 -N 4 -j $LAUNCHER_SIZE_OFFSET "$file" | tr -d ' '`
   PAYLOAD_SIZE=`od -An -t u4 -N 4 -j $PAYLOAD_SIZE_OFFSET "$file" | tr -d ' '`
   PREPAYLOAD_SIZE=`od -An -t u4 -N 4 -j $PREPAYLOAD_SIZE_OFFSET "$file" | tr -d ' '`

   SKIP_BYTES=$(($PREPAYLOAD_SIZE + $LAUNCHER_SIZE))

   return 0
}

if is_relative "${ORIGFILE}"; then
	ORIGFILE="`pwd`/${ORIGFILE}"
fi


set_offsets ${ORIGFILE}
set_lengths ${ORIGFILE}

echo "Unbundling" ${ORIGFILE}

PREPAYLOAD="prepayload"
PAYLOAD="payload"

# Unpack the pre-payload file
mkdir ${PREPAYLOAD}
cd ${PREPAYLOAD}
dd if="${ORIGFILE}" ibs=$LAUNCHER_SIZE obs=1024 skip=1 | tar -xzf - 2> /dev/null
cd ..

# Unpack the main file
mkdir ${PAYLOAD}
cd ${PAYLOAD}
dd if="${ORIGFILE}" ibs=$SKIP_BYTES obs=1024 skip=1 | tar -xzf - 2> /dev/null
cd ..

