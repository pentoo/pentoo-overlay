#!/usr/bin/env python

import lief
import sys

if len(sys.argv) < 3:
    print("Run: lief_inject <nativelib>.so <libfrida-gadget>.so ")
    sys.exit(1)

libnative = lief.parse(sys.argv[1])
libnative.add_library(sys.argv[2]) # Inject frida-gadget
libnative.write(sys.argv[1])
