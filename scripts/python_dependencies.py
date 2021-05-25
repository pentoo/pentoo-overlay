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

def gentoo_mapping(search):
    mapping =  {
        "dev-python/prompt-toolkit": "dev-python/prompt_toolkit",
        "dev-python/bs4": "dev-python/beautifulsoup:4",
        "dev-python/ruamel.yaml": "dev-python/ruamel-yaml",
        "dev-python/pycrypto": "dev-python/pycryptodome",
        "dev-python/Django": "dev-python/django",
        "dev-python/frida": "dev-python/frida-python",
        "dev-python/lief": "dev-util/lief",
        "dev-python/androguard": "dev-util/androguard",
    }

    for key in mapping:
        search = search.replace(key, mapping[key])
    return search

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
            print("\t>="+gentoo_mapping("dev-python/"+requires[0])+"-"+requires[1]+"[${PYTHON_USEDEP}]")
        else:
            print("\t"+gentoo_mapping("dev-python/"+requires[0])+"[${PYTHON_USEDEP}]")
    print("\"")

if __name__ == '__main__':
    main()
