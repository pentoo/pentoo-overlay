#!/usr/bin/env python
#
# Python-bindings access_control_list type test script
#
# Copyright (C) 2009-2022, Joachim Metz <joachim.metz@gmail.com>
#
# Refer to AUTHORS for acknowledgements.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

from __future__ import unicode_literals

import unittest

import pyfwnt


class AccessControlListTypeTests(unittest.TestCase):
  """Tests the access_control_list type."""

  def test_init(self):
    """Tests the init function."""
    with self.assertRaises(NotImplementedError):
      pyfwnt.access_control_list()


if __name__ == "__main__":
  unittest.main(verbosity=2)
