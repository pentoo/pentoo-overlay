#!/bin/bash

CONFIG_FILE="${D}/etc/vmware/config"

remove_key() {
  local key=${1}
  grep -v "^${key} =" ${CONFIG_FILE}
  grep -v "^${key} =" ${CONFIG_FILE} > ${CONFIG_FILE}.tmp
  mv ${CONFIG_FILE}.tmp ${CONFIG_FILE}
}

add_key() {
  local key=${1}
  local value=${2}
  echo "${1} = \"${2}\"" >> ${CONFIG_FILE}
}

mkdir -p $(dirname ${CONFIG_FILE})
touch ${CONFIG_FILE}

if [ "${1}" == "-s" ]; then
  remove_key ${2}
  add_key ${2} ${3/${D}/}
fi

if [ "${1}" == "-d" ]; then
  remove_key ${2}
fi

