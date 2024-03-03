#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
This script extracts
"""
__author__ = "Anton Bolshakov"

import sys
import os

import glob
import shutil


path_packages = os.path.expanduser("~/.nuget/packages")

def main(argv):

    if not os.path.isdir(path_packages):
        sys.exit("nuget directory (%s) not found" % packages)

    for dir_name in os.listdir(path_packages):
        path_version = os.path.join(path_packages, dir_name)
        if os.path.isdir(path_version):
            for dir_version in os.listdir(path_version):
                print("%s@%s" % (dir_name, dir_version))

    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv))
