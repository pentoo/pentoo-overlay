# Copyright (C) 2017-2019 Greenbone Networks GmbH
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# pylint: disable=invalid-name
import os
import sys

from setuptools import setup, find_packages

sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

version = __import__('gvmtools').get_version()

with open('README.md', 'r') as f:
    long_description = f.read()

setup(
    name='gvm-tools',
    version=version,
    author='Greenbone Networks GmbH',
    author_email='info@greenbone.net',
    description='Tools to control a GSM/GVM over GMP or OSP',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://github.com/greenbone/gvm-tools',
    packages=find_packages(),
    entry_points={
        'console_scripts': [
            'gvm-pyshell=gvmtools.pyshell:main',
            'gvm-cli=gvmtools.cli:main',
            'gvm-script=gvmtools.script:main',
        ],
    },
    install_requires=[
        'python-gvm',
    ],
    python_requires='>=3.5',
    classifiers=[
        # Full list: https://pypi.org/pypi?%3Aaction=list_classifiers
        'Development Status :: 5 - Production/Stable',
        'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        'Environment :: Console',
        'Intended Audience :: Developers',
        'Intended Audience :: System Administrators',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Operating System :: OS Independent',
        'Topic :: Software Development :: Libraries :: Python Modules',
    ],
)
