#!/usr/bin/env python3

"""Utility to generate DEPEND data for ebuilds
"""

import distutils.core

__author__ = "Anton Bolshakov"
__license__ = "GPL-3"
__email__ = "blshkv@pentoo.ch"

#def split_re(delimiters, string, maxsplit=0):
#    import re
#    regexPattern = '|'.join(map(re.escape, delimiters))
#    return re.split(regexPattern, string, maxsplit)

def split_re(delimiters, string, maxsplit=0):
    import re
    return re.split(delimiters, string, maxsplit)

def main():
    setup = distutils.core.run_setup("./setup.py")
    #print(setup.install_requires)

    print("RDEPEND=\"")
    for i in setup.install_requires:
        requires = split_re(">=|==",i,1)
        if len(requires) == 2:
            print("\t>="+requires[0]+"-"+requires[1]+"[${PYTHON_USEDEP}]")
        else:
            print("\t"+requires[0]+"[${PYTHON_USEDEP}]")
    print("\"")

if __name__ == '__main__':
    main()
