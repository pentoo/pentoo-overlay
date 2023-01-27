#!/usr/bin/env python
#
# Python-bindings stream type test script
#
# Copyright (C) 2011-2022, Joachim Metz <joachim.metz@gmail.com>
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

import pywrc


class StreamTypeTests(unittest.TestCase):
  """Tests the stream type."""

  def test_signal_abort(self):
    """Tests the signal_abort function."""
    wrc_stream = pywrc.stream()

    wrc_stream.signal_abort()

  def test_open(self):
    """Tests the open function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    if unittest.virtual_address is None:
      raise unittest.SkipTest("missing virtual address")

    wrc_stream = pywrc.stream()
    wrc_stream.set_virtual_address(unittest.virtual_address)

    wrc_stream.open(test_source)

    with self.assertRaises(IOError):
      wrc_stream.open(test_source)

    wrc_stream.close()

    with self.assertRaises(TypeError):
      wrc_stream.open(None)

    with self.assertRaises(ValueError):
      wrc_stream.open(test_source, mode="w")

  def test_open_file_object(self):
    """Tests the open_file_object function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    if not os.path.isfile(test_source):
      raise unittest.SkipTest("source not a regular file")

    if unittest.virtual_address is None:
      raise unittest.SkipTest("missing virtual address")

    wrc_stream = pywrc.stream()
    wrc_stream.set_virtual_address(unittest.virtual_address)

    with open(test_source, "rb") as file_object:

      wrc_stream.open_file_object(file_object)

      with self.assertRaises(IOError):
        wrc_stream.open_file_object(file_object)

      wrc_stream.close()

      with self.assertRaises(TypeError):
        wrc_stream.open_file_object(None)

      with self.assertRaises(ValueError):
        wrc_stream.open_file_object(file_object, mode="w")

  def test_close(self):
    """Tests the close function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    wrc_stream = pywrc.stream()

    with self.assertRaises(IOError):
      wrc_stream.close()

  def test_open_close(self):
    """Tests the open and close functions."""
    test_source = unittest.source
    if not test_source:
      return

    if unittest.virtual_address is None:
      raise unittest.SkipTest("missing virtual address")

    wrc_stream = pywrc.stream()
    wrc_stream.set_virtual_address(unittest.virtual_address)

    # Test open and close.
    wrc_stream.open(test_source)
    wrc_stream.close()

    # Test open and close a second time to validate clean up on close.
    wrc_stream.open(test_source)
    wrc_stream.close()

    if os.path.isfile(test_source):
      with open(test_source, "rb") as file_object:

        # Test open_file_object and close.
        wrc_stream.open_file_object(file_object)
        wrc_stream.close()

        # Test open_file_object and close a second time to validate clean up on close.
        wrc_stream.open_file_object(file_object)
        wrc_stream.close()

        # Test open_file_object and close and dereferencing file_object.
        wrc_stream.open_file_object(file_object)
        del file_object
        wrc_stream.close()

  def test_set_ascii_codepage(self):
    """Tests the set_ascii_codepage function."""
    supported_codepages = (
        "ascii", "cp874", "cp932", "cp936", "cp949", "cp950", "cp1250",
        "cp1251", "cp1252", "cp1253", "cp1254", "cp1255", "cp1256", "cp1257",
        "cp1258")

    wrc_stream = pywrc.stream()

    for codepage in supported_codepages:
      wrc_stream.set_ascii_codepage(codepage)

    unsupported_codepages = (
        "iso-8859-1", "iso-8859-2", "iso-8859-3", "iso-8859-4", "iso-8859-5",
        "iso-8859-6", "iso-8859-7", "iso-8859-8", "iso-8859-9", "iso-8859-10",
        "iso-8859-11", "iso-8859-13", "iso-8859-14", "iso-8859-15",
        "iso-8859-16", "koi8_r", "koi8_u")

    for codepage in unsupported_codepages:
      with self.assertRaises(RuntimeError):
        wrc_stream.set_ascii_codepage(codepage)

  def test_get_ascii_codepage(self):
    """Tests the get_ascii_codepage function and ascii_codepage property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    if unittest.virtual_address is None:
      raise unittest.SkipTest("missing virtual address")

    wrc_stream = pywrc.stream()
    wrc_stream.set_virtual_address(unittest.virtual_address)

    wrc_stream.open(test_source)

    ascii_codepage = wrc_stream.get_ascii_codepage()
    self.assertIsNotNone(ascii_codepage)

    self.assertIsNotNone(wrc_stream.ascii_codepage)

    wrc_stream.close()

  def test_get_virtual_address(self):
    """Tests the get_virtual_address function and virtual_address property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    if unittest.virtual_address is None:
      raise unittest.SkipTest("missing virtual address")

    wrc_stream = pywrc.stream()
    wrc_stream.set_virtual_address(unittest.virtual_address)

    wrc_stream.open(test_source)

    virtual_address = wrc_stream.get_virtual_address()
    self.assertIsNotNone(virtual_address)

    self.assertIsNotNone(wrc_stream.virtual_address)

    wrc_stream.close()

  def test_get_number_of_resources(self):
    """Tests the get_number_of_resources function and number_of_resources property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    if unittest.virtual_address is None:
      raise unittest.SkipTest("missing virtual address")

    wrc_stream = pywrc.stream()
    wrc_stream.set_virtual_address(unittest.virtual_address)

    wrc_stream.open(test_source)

    number_of_resources = wrc_stream.get_number_of_resources()
    self.assertIsNotNone(number_of_resources)

    self.assertIsNotNone(wrc_stream.number_of_resources)

    wrc_stream.close()


if __name__ == "__main__":
  argument_parser = argparse.ArgumentParser()

  argument_parser.add_argument(
      "-v", "--virtual_address", "--virtual-address", dest="virtual_address",
      action="store", default=None, type=int, help=(
          "virtual address of the source file."))

  argument_parser.add_argument(
      "source", nargs="?", action="store", metavar="PATH",
      default=None, help="path of the source file.")

  options, unknown_options = argument_parser.parse_known_args()
  unknown_options.insert(0, sys.argv[0])

  setattr(unittest, "virtual_address", options.virtual_address)
  setattr(unittest, "source", options.source)

  unittest.main(argv=unknown_options, verbosity=2)
