#!/usr/bin/env python
#
# Python-bindings handle type test script
#
# Copyright (C) 2014-2022, Joachim Metz <joachim.metz@gmail.com>
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

import argparse
import os
import sys
import unittest

import pyvslvm


class HandleTypeTests(unittest.TestCase):
  """Tests the handle type."""

  def test_signal_abort(self):
    """Tests the signal_abort function."""
    vslvm_handle = pyvslvm.handle()

    vslvm_handle.signal_abort()

  def test_open(self):
    """Tests the open function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    vslvm_handle = pyvslvm.handle()

    vslvm_handle.open(test_source)

    with self.assertRaises(IOError):
      vslvm_handle.open(test_source)

    vslvm_handle.close()

    with self.assertRaises(TypeError):
      vslvm_handle.open(None)

    with self.assertRaises(ValueError):
      vslvm_handle.open(test_source, mode="w")

  def test_open_file_object(self):
    """Tests the open_file_object function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    if not os.path.isfile(test_source):
      raise unittest.SkipTest("source not a regular file")

    vslvm_handle = pyvslvm.handle()

    with open(test_source, "rb") as file_object:

      vslvm_handle.open_file_object(file_object)

      with self.assertRaises(IOError):
        vslvm_handle.open_file_object(file_object)

      vslvm_handle.close()

      with self.assertRaises(TypeError):
        vslvm_handle.open_file_object(None)

      with self.assertRaises(ValueError):
        vslvm_handle.open_file_object(file_object, mode="w")

  def test_close(self):
    """Tests the close function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    vslvm_handle = pyvslvm.handle()

    with self.assertRaises(IOError):
      vslvm_handle.close()

  def test_open_close(self):
    """Tests the open and close functions."""
    test_source = unittest.source
    if not test_source:
      return

    vslvm_handle = pyvslvm.handle()

    # Test open and close.
    vslvm_handle.open(test_source)
    vslvm_handle.close()

    # Test open and close a second time to validate clean up on close.
    vslvm_handle.open(test_source)
    vslvm_handle.close()

    if os.path.isfile(test_source):
      with open(test_source, "rb") as file_object:

        # Test open_file_object and close.
        vslvm_handle.open_file_object(file_object)
        vslvm_handle.close()

        # Test open_file_object and close a second time to validate clean up on close.
        vslvm_handle.open_file_object(file_object)
        vslvm_handle.close()

        # Test open_file_object and close and dereferencing file_object.
        vslvm_handle.open_file_object(file_object)
        del file_object
        vslvm_handle.close()

  def test_get_volume_group(self):
    """Tests the get_volume_group function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    vslvm_handle = pyvslvm.handle()

    vslvm_handle.open(test_source)

    volume_group = vslvm_handle.get_volume_group()
    self.assertIsNotNone(volume_group)

    vslvm_handle.close()


if __name__ == "__main__":
  argument_parser = argparse.ArgumentParser()

  argument_parser.add_argument(
      "source", nargs="?", action="store", metavar="PATH",
      default=None, help="path of the source file.")

  options, unknown_options = argument_parser.parse_known_args()
  unknown_options.insert(0, sys.argv[0])

  setattr(unittest, "source", options.source)

  unittest.main(argv=unknown_options, verbosity=2)
