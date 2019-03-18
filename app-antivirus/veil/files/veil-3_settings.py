#!/usr/bin/python

##################################################################################################
#
# Veil configuration file
#
# Run 'Veil.py --config' to automatically set all these options to their defaults.
#
##################################################################################################

import os

#################################################
#
# General system options
#
#################################################
# OS to use (Kali/Backtrack/Debian/Windows)
OPERATING_SYSTEM="Linux"

# Specific Linux distro
DISTRO="Linux"

# Terminal clearing method to use (use "false" to disable it)
TERMINAL_CLEAR="clear"

# Veil install path
VEIL_PATH="/usr/lib/veil"

# Wine environment
WINEPREFIX="/usr/lib/wine/"

# Path to temporary directory
TEMP_PATH="/tmp/"

# The path to the metasploit framework, for example: /usr/lib/metasploit/
METASPLOIT_PATH="/usr/lib/metasploit/"

# The path to msfvenom for shellcode generation purposes
MSFVENOM_PATH="/usr/bin/"

# Default options to pass to msfvenom for shellcode creation
MSFVENOM_OPTIONS=""

# The path to pyinstaller, for example: /var/lib/veil/PyInstaller-3.2.1/
PYINSTALLER_PATH="/var/lib/veil/PyInstaller-3.2.1/"

# The path to pyinstaller, for example: /usr/lib/go/
GOLANG_PATH="/usr/lib/go/"



#################################################
#
# Veil-Evasion specific options
#
#################################################
# Path to output the source of payloads
PAYLOAD_SOURCE_PATH=os.path.expanduser("~/.veil/output/source/")

# Path to output compiled payloads
PAYLOAD_COMPILED_PATH=os.path.expanduser("~/.veil/output/compiled/")

# Where to generate a msf handler script
HANDLER_PATH=os.path.expanduser("~/.veil/output/handlers/")

# Running hash list of all payloads generated
HASH_LIST=os.path.expanduser("~/.veil/output/hashes.txt")

