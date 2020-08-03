#!/usr/bin/env python3

"""Parse Repology API and display outdated packages in Pentoo
"""

import json
import requests
import sys

__author__ = "Anton Bolshakov"
__license__ = "GPL-3"
__email__ = "blshkv@pentoo.ch"

outdated_url = "https://repology.org/api/v1/metapackages/?inrepo=gentoo_ovl_pentoo&outdated=1"

ignore_packages = {
'sys-power/acpid',
'www-apps/arachni',
'app-misc/dradis',
'dev-libs/openssl-chacha',
'net-wireless/crda',
'net-wireless/hostapd',
'net-wireless/rtl8812au',
'net-wireless/wireless-regdb',
'net-analyzer/set',
'net-dialup/freeradius'
}

json_data = None

def load_api():
    global json_data

    #get the outdated list via API (json)
    try:
        response = requests.get(outdated_url)
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

    load_api()

    for packages in json_data:
        for package in json_data[packages]:
            #find the newest version
            if package["status"] == "newest":
                package_version_newest = package["version"]
            #find the current outdated in Pentoo
            if package["repo"] == "gentoo_ovl_pentoo" and package["status"] == "outdated":
#                gentoo_package_fullname = package["categories"][0] + "/" + package["srcname"]
                gentoo_package_name = package["srcname"]
                gentoo_package_version = package["version"]
                gentoo_package_category = package["categories"][0]

        #do not display some known packages
        if gentoo_package_name in ignore_packages:
            continue
        #print the outdated list
        print ("cp " + gentoo_package_name + "-" + gentoo_package_version + ".ebuild " + \
            gentoo_package_name + "-"+ package_version_newest + ".ebuild")


if __name__ == '__main__':
    main()
