#!/usr/bin/env python
#
# Python-bindings handle type test script
#
# Copyright (C) 2006-2022, Joachim Metz <joachim.metz@gmail.com>
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
import random
import sys
import unittest

import pyewf


class HandleTypeTests(unittest.TestCase):
  """Tests the handle type."""

  def test_signal_abort(self):
    """Tests the signal_abort function."""
    ewf_handle = pyewf.handle()

    ewf_handle.signal_abort()

  def test_open(self):
    """Tests the open function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    # TODO: fix
    # with self.assertRaises(IOError):
    #   ewf_handle.open(filenames)

    ewf_handle.close()

    with self.assertRaises(TypeError):
      ewf_handle.open(None)

  def test_open_file_objects(self):
    """Tests the open_file_objects function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    if not os.path.isfile(test_source):
      raise unittest.SkipTest("source not a regular file")

    filenames = pyewf.glob(test_source)
    file_objects = [open(filename, "rb") for filename in filenames]

    ewf_handle = pyewf.handle()

    ewf_handle.open_file_objects(file_objects)

    # TODO: change IOError into IOError
    with self.assertRaises(MemoryError):
      ewf_handle.open_file_objects(file_objects)

    ewf_handle.close()

    with self.assertRaises(TypeError):
      ewf_handle.open_file_objects(None)

    for file_object in file_objects:
      file_object.close()

  def test_close(self):
    """Tests the close function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    ewf_handle = pyewf.handle()

    # TODO: fix
    # with self.assertRaises(IOError):
    #   ewf_handle.close()

  def test_open_close(self):
    """Tests the open and close functions."""
    test_source = unittest.source
    if not test_source:
      return

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    # Test open and close.
    ewf_handle.open(filenames)
    ewf_handle.close()

    # Test open and close a second time to validate clean up on close.
    ewf_handle.open(filenames)
    ewf_handle.close()

    if os.path.isfile(test_source):
      with open(test_source, "rb") as file_object:

        # Test open_file_objects and close.
        ewf_handle.open_file_objects([file_object])
        ewf_handle.close()

        # Test open_file_objects and close a second time to validate clean up on close.
        ewf_handle.open_file_objects([file_object])
        ewf_handle.close()

        # Test open_file_objects and close and dereferencing file_object.
        ewf_handle.open_file_objects([file_object])
        del file_object
        ewf_handle.close()

  def test_read_buffer(self):
    """Tests the read_buffer function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    media_size = ewf_handle.get_media_size()

    if media_size < 4096:
      # Test read without maximum size.
      ewf_handle.seek_offset(0, os.SEEK_SET)

      data = ewf_handle.read_buffer()

      self.assertIsNotNone(data)
      self.assertEqual(len(data), media_size)

    # Test read with maximum size.
    ewf_handle.seek_offset(0, os.SEEK_SET)

    data = ewf_handle.read_buffer(size=4096)

    self.assertIsNotNone(data)
    self.assertEqual(len(data), min(media_size, 4096))

    if media_size > 8:
      ewf_handle.seek_offset(-8, os.SEEK_END)

      # Read buffer on media_size boundary.
      data = ewf_handle.read_buffer(size=4096)

      self.assertIsNotNone(data)
      self.assertEqual(len(data), 8)

      # Read buffer beyond media_size boundary.
      data = ewf_handle.read_buffer(size=4096)

      self.assertIsNotNone(data)
      self.assertEqual(len(data), 0)

    # Stress test read buffer.
    ewf_handle.seek_offset(0, os.SEEK_SET)

    remaining_media_size = media_size

    for _ in range(1024):
      read_size = int(random.random() * 4096)

      data = ewf_handle.read_buffer(size=read_size)

      self.assertIsNotNone(data)

      data_size = len(data)

      if read_size > remaining_media_size:
        read_size = remaining_media_size

      self.assertEqual(data_size, read_size)

      remaining_media_size -= data_size

      if not remaining_media_size:
        ewf_handle.seek_offset(0, os.SEEK_SET)

        remaining_media_size = media_size

    with self.assertRaises(ValueError):
      ewf_handle.read_buffer(size=-1)

    ewf_handle.close()

    # Test the read without open.
    with self.assertRaises(IOError):
      ewf_handle.read_buffer(size=4096)

  def test_read_buffer_file_object(self):
    """Tests the read_buffer function on a file-like object."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    if not os.path.isfile(test_source):
      raise unittest.SkipTest("source not a regular file")

    ewf_handle = pyewf.handle()

    with open(test_source, "rb") as file_object:
      ewf_handle.open_file_objects([file_object])

      media_size = ewf_handle.get_media_size()

      # Test normal read.
      data = ewf_handle.read_buffer(size=4096)

      self.assertIsNotNone(data)
      self.assertEqual(len(data), min(media_size, 4096))

      ewf_handle.close()

  def test_read_buffer_at_offset(self):
    """Tests the read_buffer_at_offset function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    media_size = ewf_handle.get_media_size()

    # Test normal read.
    data = ewf_handle.read_buffer_at_offset(4096, 0)

    self.assertIsNotNone(data)
    self.assertEqual(len(data), min(media_size, 4096))

    if media_size > 8:
      # Read buffer on media_size boundary.
      data = ewf_handle.read_buffer_at_offset(4096, media_size - 8)

      self.assertIsNotNone(data)
      self.assertEqual(len(data), 8)

      # Read buffer beyond media_size boundary.
      data = ewf_handle.read_buffer_at_offset(4096, media_size + 8)

      self.assertIsNotNone(data)
      self.assertEqual(len(data), 0)

    # Stress test read buffer.
    for _ in range(1024):
      random_number = random.random()

      media_offset = int(random_number * media_size)
      read_size = int(random_number * 4096)

      data = ewf_handle.read_buffer_at_offset(read_size, media_offset)

      self.assertIsNotNone(data)

      remaining_media_size = media_size - media_offset

      data_size = len(data)

      if read_size > remaining_media_size:
        read_size = remaining_media_size

      self.assertEqual(data_size, read_size)

      remaining_media_size -= data_size

      if not remaining_media_size:
        ewf_handle.seek_offset(0, os.SEEK_SET)

    with self.assertRaises(ValueError):
      ewf_handle.read_buffer_at_offset(-1, 0)

    with self.assertRaises(ValueError):
      ewf_handle.read_buffer_at_offset(4096, -1)

    ewf_handle.close()

    # Test the read without open.
    with self.assertRaises(IOError):
      ewf_handle.read_buffer_at_offset(4096, 0)

  def test_seek_offset(self):
    """Tests the seek_offset function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    media_size = ewf_handle.get_media_size()

    ewf_handle.seek_offset(16, os.SEEK_SET)

    offset = ewf_handle.get_offset()
    self.assertEqual(offset, 16)

    ewf_handle.seek_offset(16, os.SEEK_CUR)

    offset = ewf_handle.get_offset()
    self.assertEqual(offset, 32)

    ewf_handle.seek_offset(-16, os.SEEK_CUR)

    offset = ewf_handle.get_offset()
    self.assertEqual(offset, 16)

    if media_size > 16:
      ewf_handle.seek_offset(-16, os.SEEK_END)

      offset = ewf_handle.get_offset()
      self.assertEqual(offset, media_size - 16)

    ewf_handle.seek_offset(16, os.SEEK_END)

    offset = ewf_handle.get_offset()
    self.assertEqual(offset, media_size + 16)

    # TODO: change IOError into ValueError
    with self.assertRaises(IOError):
      ewf_handle.seek_offset(-1, os.SEEK_SET)

    # TODO: change IOError into ValueError
    with self.assertRaises(IOError):
      ewf_handle.seek_offset(-32 - media_size, os.SEEK_CUR)

    # TODO: change IOError into ValueError
    with self.assertRaises(IOError):
      ewf_handle.seek_offset(-32 - media_size, os.SEEK_END)

    # TODO: change IOError into ValueError
    with self.assertRaises(IOError):
      ewf_handle.seek_offset(0, -1)

    ewf_handle.close()

    # Test the seek without open.
    with self.assertRaises(IOError):
      ewf_handle.seek_offset(16, os.SEEK_SET)

  def test_seek_offset_file_object(self):
    """Tests the seek_offset function on a file-like object."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    if not os.path.isfile(test_source):
      raise unittest.SkipTest("source not a regular file")

    ewf_handle = pyewf.handle()

    with open(test_source, "rb") as file_object:
      ewf_handle.open_file_objects([file_object])

      offset = ewf_handle.get_offset()
      self.assertEqual(offset, 0)

      ewf_handle.seek_offset(16, os.SEEK_SET)

      offset = ewf_handle.get_offset()
      self.assertEqual(offset, 16)

      ewf_handle.close()

  def test_get_offset(self):
    """Tests the get_offset function."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    offset = ewf_handle.get_offset()
    self.assertIsNotNone(offset)

    ewf_handle.close()

  def test_get_root_file_entry(self):
    """Tests the get_root_file_entry function and root_file_entry property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    # TODO: check media type and skip if not LEF

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    # root_file_entry = ewf_handle.get_root_file_entry()
    # self.assertIsNotNone(root_file_entry)

    # self.assertIsNotNone(ewf_handle.root_file_entry)

    ewf_handle.close()

  def test_get_sectors_per_chunk(self):
    """Tests the get_sectors_per_chunk function and sectors_per_chunk property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    sectors_per_chunk = ewf_handle.get_sectors_per_chunk()
    self.assertIsNotNone(sectors_per_chunk)

    self.assertIsNotNone(ewf_handle.sectors_per_chunk)

    ewf_handle.close()

  def test_get_bytes_per_sector(self):
    """Tests the get_bytes_per_sector function and bytes_per_sector property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    bytes_per_sector = ewf_handle.get_bytes_per_sector()
    self.assertIsNotNone(bytes_per_sector)

    self.assertIsNotNone(ewf_handle.bytes_per_sector)

    ewf_handle.close()

  def test_get_number_of_sectors(self):
    """Tests the get_number_of_sectors function and number_of_sectors property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    number_of_sectors = ewf_handle.get_number_of_sectors()
    self.assertIsNotNone(number_of_sectors)

    self.assertIsNotNone(ewf_handle.number_of_sectors)

    ewf_handle.close()

  def test_get_chunk_size(self):
    """Tests the get_chunk_size function and chunk_size property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    chunk_size = ewf_handle.get_chunk_size()
    self.assertIsNotNone(chunk_size)

    self.assertIsNotNone(ewf_handle.chunk_size)

    ewf_handle.close()

  def test_get_error_granularity(self):
    """Tests the get_error_granularity function and error_granularity property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    error_granularity = ewf_handle.get_error_granularity()
    self.assertIsNotNone(error_granularity)

    self.assertIsNotNone(ewf_handle.error_granularity)

    ewf_handle.close()

  def test_get_compression_method(self):
    """Tests the get_compression_method function and compression_method property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    compression_method = ewf_handle.get_compression_method()
    self.assertIsNotNone(compression_method)

    self.assertIsNotNone(ewf_handle.compression_method)

    ewf_handle.close()

  def test_get_media_size(self):
    """Tests the get_media_size function and media_size property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    media_size = ewf_handle.get_media_size()
    self.assertIsNotNone(media_size)

    self.assertIsNotNone(ewf_handle.media_size)

    ewf_handle.close()

  def test_get_media_type(self):
    """Tests the get_media_type function and media_type property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    media_type = ewf_handle.get_media_type()
    self.assertIsNotNone(media_type)

    self.assertIsNotNone(ewf_handle.media_type)

    ewf_handle.close()

  def test_get_media_flags(self):
    """Tests the get_media_flags function and media_flags property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    media_flags = ewf_handle.get_media_flags()
    self.assertIsNotNone(media_flags)

    self.assertIsNotNone(ewf_handle.media_flags)

    ewf_handle.close()

  def test_get_format(self):
    """Tests the get_format function and format property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    format = ewf_handle.get_format()
    self.assertIsNotNone(format)

    self.assertIsNotNone(ewf_handle.format)

    ewf_handle.close()

  def test_get_header_codepage(self):
    """Tests the get_header_codepage function and header_codepage property."""
    test_source = unittest.source
    if not test_source:
      raise unittest.SkipTest("missing source")

    filenames = pyewf.glob(test_source)

    ewf_handle = pyewf.handle()

    ewf_handle.open(filenames)

    header_codepage = ewf_handle.get_header_codepage()
    self.assertIsNotNone(header_codepage)

    self.assertIsNotNone(ewf_handle.header_codepage)

    ewf_handle.close()


if __name__ == "__main__":
  argument_parser = argparse.ArgumentParser()

  argument_parser.add_argument(
      "source", nargs="?", action="store", metavar="PATH",
      default=None, help="path of the source file.")

  options, unknown_options = argument_parser.parse_known_args()
  unknown_options.insert(0, sys.argv[0])

  setattr(unittest, "source", options.source)

  unittest.main(argv=unknown_options, verbosity=2)
