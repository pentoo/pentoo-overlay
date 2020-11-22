#!/usr/bin/env python3

"""Parse Cargo.lock and generate CRATES list
"""

import re

__author__ = "Anton Bolshakov"
__license__ = "GPL-3"
__email__ = "blshkv@pentoo.ch"

def analyze_log(f):
    for line in f:

        m = re.search('name = "(.+?)"', line)
        if m:
            print(m.group(1) , end = '-')
            continue

        m = re.search('version = "(.+?)"', line)
        if m:
            print(m.group(1))
            continue

#def write_stats(stats, f):
#    out = csv.writer(f)
#    out.writerow(…)
#    for var in stats:
#        out.writerow(…)

def main(input_filename, output_filename):
    with open(input_filename) as input_file:
        stats = analyze_log(input_file)
#    with open(output_filename, 'w') as output_file:
#        write_stats(stats, output_file)

if __name__ == '__main__':
    main(r'./Cargo.lock', r'./Cargo.deps')
