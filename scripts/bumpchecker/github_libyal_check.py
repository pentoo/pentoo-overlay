#!/usr/bin/env python3

""" Find the latest releases of lybyal* using Github API
"""

import json
import requests
import sys

__author__ = "Anton Bolshakov"
__license__ = "GPL-3"
__email__ = "blshkv@pentoo.ch"

project_url = "https://api.github.com/repos/libyal/"

project_packages = {

'libcdata',
'libcdatetime',
'libcerror',
'libcfile',
'libclocale',
'libcnotify',
'libcpath',
'libcsplit',
'libcstring',
'libcsystem',
'libcthreads',
'libfcache',
'libfdata',
'libfdatetime',
'libfguid',
'libfmapi',
'libfvalue',
'libfwnt',
'libsmdev',
'libuna'
}

json_data = None

def load_api( package ):
    global json_data

    #get the tag list via API (json)
    try:
        response = requests.get(project_url + package +"/tags")
        response.raise_for_status()
    except requests.exceptions.HTTPError as errh:
        print ("Http Error:",errh)
        sys.exit(1)
    except requests.exceptions.ConnectionError as errc:
        print ("Unable to connect:",errc)
        sys.exit(1)
    except requests.exceptions.Timeout as errt:
        print ("Timeout Error:",errt)
        sys.exit(1)
    except requests.exceptions.RequestException as err:
        print ("OOps: Something Else",err)
        sys.exit(1)
    #parse json
    json_data = json.loads(response.text)

def main():
    for package in project_packages:
        load_api(package)
        print("package: ", package, "-", json_data[0]["name"])

if __name__ == '__main__':
    main()
