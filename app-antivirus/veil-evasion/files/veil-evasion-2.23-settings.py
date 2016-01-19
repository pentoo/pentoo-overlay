#!/usr/bin/python

##################################################################################################
#
# Veil-Framework configuration file
#
# Run update.py to automatically set all these options to their defaults.
#
##################################################################################################



#################################################
#
# General system options
#
#################################################

# OS to use (Kali/Backtrack/Debian/Windows)
OPERATING_SYSTEM="Linux"

# Terminal clearing method to use (use "false" to disable it)
TERMINAL_CLEAR="clear"

# Path to temporary directory
TEMP_DIR="/tmp/"

# Default options to pass to msfvenom for shellcode creation
MSFVENOM_OPTIONS=""

# The path to the metasploit framework, for example: /usr/share/metasploit-framework/
METASPLOIT_PATH="/usr/lib/metasploit"

# The path to msfvenom for shellcode generation purposes
MSFVENOM_PATH="/usr/bin/"

# The path to pyinstaller, for example: /opt/pyinstaller-2.0/
PYINSTALLER_PATH="/opt/pyinstaller-2.0/"


#################################################
#
# Veil-Evasion specific options
#
#################################################
import os
from os.path import expanduser
HOME_PATH = expanduser("~")

VEIL_RESULTS_PATH=HOME_PATH+"/.veil-evasion"

# Veil-Evasion install path
VEIL_EVASION_PATH="/usr/lib/veil-evasion"

# Path to output the source of payloads
PAYLOAD_SOURCE_PATH=VEIL_RESULTS_PATH+"/source/"

# Path to output compiled payloads
PAYLOAD_COMPILED_PATH=VEIL_RESULTS_PATH+"/compiled/"

# Whether to generate a msf handler script and where to place it
GENERATE_HANDLER_SCRIPT="True"
HANDLER_PATH=VEIL_RESULTS_PATH+"/handlers/"

# Running hash list of all payloads generated
HASH_LIST=VEIL_RESULTS_PATH+"/hashes.txt"


#################################################
#
# Veil-Catapult specific options
#
#################################################

# Veil-Catapult install path
VEIL_CATAPULT_PATH=VEIL_EVASION_PATH+"/veil-catapult/"

# Path to output Veil-Catapult resource/cleanup files
CATAPULT_RESOURCE_PATH=VEIL_RESULTS_PATH+"/catapult/"

os.makedirs(PAYLOAD_SOURCE_PATH)
os.makedirs(PAYLOAD_COMPILED_PATH)
os.makedirs(HANDLER_PATH)
os.makedirs(CATAPULT_RESOURCE_PATH)
