#!/usr/bin/env python3

"""Parse Repology API and display outdated packages in Pentoo
"""

import time
import requests
import sys

__author__ = "Anton Bolshakov"
__license__ = "GPL-3"
__email__ = "blshkv@pentoo.ch"

OUTDATED_URL = "https://repology.org/api/v1/projects/?inrepo=gentoo_ovl_pentoo&outdated=1&families_newest=2-"
API_PAGE_SIZE = 200
API_SLEEP = 1  # seconds between paginated requests

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; pentoo_bot/1.0; +https://github.com/pentoo/pentoo-overlay/blob/master/scripts/bumpchecker/repology_check.py)"
}

IGNORE_PACKAGES = {
    'sys-power/acpid',
    'www-apps/arachni',
    'app-misc/dradis',
    'dev-libs/openssl-chacha',
    'net-wireless/crda',
    'net-wireless/hostapd',
    'net-wireless/rtl8812au',
    'net-wireless/wireless-regdb',
    'net-analyzer/set',
    'net-dialup/freeradius',
}


def fetch_page(url):
    try:
        response = requests.get(url, headers=HEADERS)
        response.raise_for_status()
    except requests.exceptions.HTTPError as errh:
        print("Http Error:", errh)
        sys.exit(1)
    except requests.exceptions.ConnectionError as errc:
        print("Unable to connect:", errc)
        sys.exit(1)
    except requests.exceptions.Timeout as errt:
        print("Timeout Error:", errt)
        sys.exit(1)
    except requests.exceptions.RequestException as err:
        print("Error:", err)
        sys.exit(1)
    return response.json()


def load_api():
    # fetch all pages of the outdated package list via Repology API
    all_data = {}
    url = OUTDATED_URL
    while True:
        page = fetch_page(url)
        all_data.update(page)
        # API returns up to API_PAGE_SIZE projects per page; if fewer came
        # back we've reached the last page
        if len(page) < API_PAGE_SIZE:
            break
        # use the last project name as the cursor for the next page
        last = list(page.keys())[-1]
        url = OUTDATED_URL + f"&start={last}"
        time.sleep(API_SLEEP)
    return all_data


def main():
    json_data = load_api()

    for packages in json_data:
        gentoo_package_category = ""
        gentoo_package_full_name = ""
        gentoo_package_version = ""
        package_version_newest = ""

        for package in json_data[packages]:
            # find the newest version across all repos
            if package["status"] == "newest":
                package_version_newest = package["version"]

            # find the outdated Pentoo package
            if package["repo"] == "gentoo_ovl_pentoo" and package["status"] == "outdated":
                categories = package.get("categories") or []
                gentoo_package_category = categories[0] if categories else ""
                gentoo_package_full_name = package["srcname"]
                gentoo_package_version = package["origversion"] or package["version"]

        # skip ignored and incomplete entries
        if not gentoo_package_full_name or gentoo_package_full_name in IGNORE_PACKAGES:
            continue
        if not package_version_newest or not gentoo_package_version:
            continue

        gentoo_package_name = gentoo_package_full_name.removeprefix(gentoo_package_category + "/")
        print(
            f"cp {gentoo_package_category}/{gentoo_package_name}/{gentoo_package_name}-{gentoo_package_version}.ebuild"
            f" {gentoo_package_category}/{gentoo_package_name}/{gentoo_package_name}-{package_version_newest}.ebuild"
        )


if __name__ == '__main__':
    main()
