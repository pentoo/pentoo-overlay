/*
 * Handle functions
 *
 * Copyright (C) 2006-2017, Joachim Metz <joachim.metz@gmail.com>
 *
 * Refer to AUTHORS for acknowledgements.
 *
 * This software is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this software.  If not, see <http://www.gnu.org/licenses/>.
 */

#if !defined( _LIBEWF_INTERNAL_HANDLE_H )
#define _LIBEWF_INTERNAL_HANDLE_H

#include <common.h>
#include <types.h>

#include "libewf_chunk_data.h"
#include "libewf_chunk_group.h"
#include "libewf_chunk_table.h"
#include "libewf_data_chunk.h"
#include "libewf_extern.h"
#include "libewf_hash_sections.h"
#include "libewf_libbfio.h"
#include "libewf_libcdata.h"
#include "libewf_libcerror.h"
#include "libewf_libcthreads.h"
#include "libewf_libfcache.h"
#include "libewf_libfdata.h"
#include "libewf_libfvalue.h"
#include "libewf_io_handle.h"
#include "libewf_media_values.h"
#include "libewf_read_io_handle.h"
#include "libewf_segment_table.h"
#include "libewf_single_files.h"
#include "libewf_types.h"
#include "libewf_write_io_handle.h"

#if defined( __cplusplus )
extern "C" {
#endif

typedef struct libewf_internal_handle libewf_internal_handle_t;

struct libewf_internal_handle
{
	/* The IO handle
	 */
	libewf_io_handle_t *io_handle;

	/* The media values
	 */
	libewf_media_values_t *media_values;

	/* The stored sessions information
	 */
	libcdata_array_t *sessions;

	/* The stored tracks information
	 */
	libcdata_array_t *tracks;

	/* The sectors with acquiry read errors
	 */
	libcdata_range_list_t *acquiry_errors;

	/* The file IO pool
	 */
	libbfio_pool_t *file_io_pool;

	/* Value to indicate if the pool was created inside the library
	 */
	uint8_t file_io_pool_created_in_library;

	/* The read IO handle
	 */
	libewf_read_io_handle_t *read_io_handle;

	/* The write IO handle
	 */
	libewf_write_io_handle_t *write_io_handle;

	/* The maximum number of open handles in the pool
	 */
	int maximum_number_of_open_handles;

	/* The current (storage media) offset
	 */
	off64_t current_offset;

	/* The current (storage media) chunk index
	 */
	uint64_t current_chunk_index;

	/* The segment file table
	 */
	libewf_segment_table_t *segment_table;

	/* The chunk table
	 */
	libewf_chunk_table_t *chunk_table;

	/* The chunk groups cache
	 */
	libfcache_cache_t *chunk_groups_cache;

	/* The chunks cache
	 */
	libfcache_cache_t *chunks_cache;

	/* The current chunk data
	 */
	libewf_chunk_data_t *chunk_data;

	/* The date format for certain header values
	 */
	int date_format;

	/* The hash sections
	 */
	libewf_hash_sections_t *hash_sections;

	/* The header values
	 */
	libfvalue_table_t *header_values;

	/* Value to indicate the header values were parsed
	 */
	uint8_t header_values_parsed;

	/* The hash values
	 */
	libfvalue_table_t *hash_values;

	/* Value to indicate the hash values were parsed
	 */
	uint8_t hash_values_parsed;

	/* The single files
	 */
	libewf_single_files_t *single_files;

#if defined( HAVE_LIBEWF_MULTI_THREAD_SUPPORT )
	/* The read/write lock
	 */
	libcthreads_read_write_lock_t *read_write_lock;
#endif
};

LIBEWF_EXTERN \
int libewf_handle_initialize(
     libewf_handle_t **handle,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_free(
     libewf_handle_t **handle,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_clone(
     libewf_handle_t **destination_handle,
     libewf_handle_t *source_handle,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_signal_abort(
     libewf_handle_t *handle,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_open(
     libewf_handle_t *handle,
     char * const filenames[],
     int number_of_filenames,
     int access_flags,
     libcerror_error_t **error );

#if defined( HAVE_WIDE_CHARACTER_TYPE )

LIBEWF_EXTERN \
int libewf_handle_open_wide(
     libewf_handle_t *handle,
     wchar_t * const filenames[],
     int number_of_filenames,
     int access_flags,
     libcerror_error_t **error );

#endif /* defined( HAVE_WIDE_CHARACTER_TYPE ) */

int libewf_internal_handle_open_read_segment_file_section_data(
     libewf_internal_handle_t *internal_handle,
     libewf_segment_file_t *segment_file,
     libbfio_pool_t *file_io_pool,
     int file_io_pool_entry,
     libcerror_error_t **error );

int libewf_internal_handle_open_read_segment_files(
     libewf_internal_handle_t *internal_handle,
     libbfio_pool_t *file_io_pool,
     libewf_segment_table_t *segment_table,
     libcerror_error_t **error );

int libewf_internal_handle_open_file_io_pool(
     libewf_internal_handle_t *internal_handle,
     libbfio_pool_t *file_io_pool,
     int access_flags,
     libewf_segment_table_t *segment_table,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_open_file_io_pool(
     libewf_handle_t *handle,
     libbfio_pool_t *file_io_pool,
     int access_flags,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_close(
     libewf_handle_t *handle,
     libcerror_error_t **error );

ssize_t libewf_internal_handle_read_buffer_from_file_io_pool(
         libewf_internal_handle_t *internal_handle,
         libbfio_pool_t *file_io_pool,
         void *buffer,
         size_t buffer_size,
         libcerror_error_t **error );

LIBEWF_EXTERN \
ssize_t libewf_handle_read_buffer(
         libewf_handle_t *handle,
         void *buffer,
         size_t buffer_size,
         libcerror_error_t **error );

LIBEWF_EXTERN \
ssize_t libewf_handle_read_buffer_at_offset(
         libewf_handle_t *handle,
         void *buffer,
         size_t buffer_size,
         off64_t offset,
         libcerror_error_t **error );

ssize_t libewf_internal_handle_write_buffer_to_file_io_pool(
         libewf_internal_handle_t *internal_handle,
         libbfio_pool_t *file_io_pool,
         const void *buffer,
         size_t buffer_size,
         libcerror_error_t **error );

LIBEWF_EXTERN \
ssize_t libewf_handle_write_buffer(
         libewf_handle_t *handle,
         const void *buffer,
         size_t buffer_size,
         libcerror_error_t **error );

LIBEWF_EXTERN \
ssize_t libewf_handle_write_buffer_at_offset(
         libewf_handle_t *handle,
         const void *buffer,
         size_t buffer_size,
         off64_t offset,
         libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_data_chunk(
     libewf_handle_t *handle,
     libewf_data_chunk_t **data_chunk,
     libcerror_error_t **error );

ssize_t libewf_internal_handle_read_data_chunk_from_file_io_pool(
         libewf_internal_handle_t *internal_handle,
         libbfio_pool_t *file_io_pool,
         libewf_internal_data_chunk_t *internal_data_chunk,
         libcerror_error_t **error );

LIBEWF_EXTERN \
ssize_t libewf_handle_read_data_chunk(
         libewf_handle_t *handle,
         libewf_data_chunk_t *data_chunk,
         libcerror_error_t **error );

ssize_t libewf_internal_handle_write_data_chunk_to_file_io_pool(
         libewf_internal_handle_t *internal_handle,
         libbfio_pool_t *file_io_pool,
         libewf_internal_data_chunk_t *internal_data_chunk,
         libcerror_error_t **error );

LIBEWF_EXTERN \
ssize_t libewf_handle_write_data_chunk(
         libewf_handle_t *handle,
         libewf_data_chunk_t *data_chunk,
         libcerror_error_t **error );

ssize_t libewf_internal_handle_write_finalize_file_io_pool(
         libewf_internal_handle_t *internal_handle,
         libbfio_pool_t *file_io_pool,
         libcerror_error_t **error );

LIBEWF_EXTERN \
ssize_t libewf_handle_write_finalize(
         libewf_handle_t *handle,
         libcerror_error_t **error );

off64_t libewf_internal_handle_seek_offset(
         libewf_internal_handle_t *internal_handle,
         off64_t offset,
         int whence,
         libcerror_error_t **error );

LIBEWF_EXTERN \
off64_t libewf_handle_seek_offset(
         libewf_handle_t *handle,
         off64_t offset,
         int whence,
         libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_offset(
     libewf_handle_t *handle,
     off64_t *offset,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_set_maximum_number_of_open_handles(
     libewf_handle_t *handle,
     int maximum_number_of_open_handles,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_segment_files_corrupted(
     libewf_handle_t *handle,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_segment_files_encrypted(
     libewf_handle_t *handle,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_segment_filename_size(
     libewf_handle_t *handle,
     size_t *filename_size,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_segment_filename(
     libewf_handle_t *handle,
     char *filename,
     size_t filename_size,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_set_segment_filename(
     libewf_handle_t *handle,
     const char *filename,
     size_t filename_length,
     libcerror_error_t **error );

#if defined( HAVE_WIDE_CHARACTER_TYPE )

LIBEWF_EXTERN \
int libewf_handle_get_segment_filename_size_wide(
     libewf_handle_t *handle,
     size_t *filename_size,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_segment_filename_wide(
     libewf_handle_t *handle,
     wchar_t *filename,
     size_t filename_size,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_set_segment_filename_wide(
     libewf_handle_t *handle,
     const wchar_t *filename,
     size_t filename_length,
     libcerror_error_t **error );

#endif /* defined( HAVE_WIDE_CHARACTER_TYPE ) */

LIBEWF_EXTERN \
int libewf_handle_get_maximum_segment_size(
     libewf_handle_t *handle,
     size64_t *maximum_segment_size,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_set_maximum_segment_size(
     libewf_handle_t *handle,
     size64_t maximum_segment_size,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_filename_size(
     libewf_handle_t *handle,
     size_t *filename_size,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_filename(
     libewf_handle_t *handle,
     char *filename,
     size_t filename_size,
     libcerror_error_t **error );

#if defined( HAVE_WIDE_CHARACTER_TYPE )

LIBEWF_EXTERN \
int libewf_handle_get_filename_size_wide(
     libewf_handle_t *handle,
     size_t *filename_size,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_filename_wide(
     libewf_handle_t *handle,
     wchar_t *filename,
     size_t filename_size,
     libcerror_error_t **error );

#endif /* defined( HAVE_WIDE_CHARACTER_TYPE ) */

int libewf_internal_handle_get_file_io_handle(
     libewf_internal_handle_t *internal_handle,
     libbfio_handle_t **file_io_handle,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_file_io_handle(
     libewf_handle_t *handle,
     libbfio_handle_t **file_io_handle,
     libcerror_error_t **error );

int libewf_internal_handle_get_media_values(
     libewf_internal_handle_t *internal_handle,
     size64_t *media_size,
     libcerror_error_t **error );

int libewf_internal_handle_set_media_values(
     libewf_internal_handle_t *internal_handle,
     uint32_t sectors_per_chunk,
     uint32_t bytes_per_sector,
     size64_t media_size,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_root_file_entry(
     libewf_handle_t *handle,
     libewf_file_entry_t **root_file_entry,
     libcerror_error_t **error );

int libewf_internal_handle_get_file_entry_by_utf8_path(
     libewf_internal_handle_t *internal_handle,
     const uint8_t *utf8_string,
     size_t utf8_string_length,
     libewf_file_entry_t **file_entry,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_file_entry_by_utf8_path(
     libewf_handle_t *handle,
     const uint8_t *utf8_string,
     size_t utf8_string_length,
     libewf_file_entry_t **file_entry,
     libcerror_error_t **error );

int libewf_internal_handle_get_file_entry_by_utf16_path(
     libewf_internal_handle_t *internal_handle,
     const uint16_t *utf16_string,
     size_t utf16_string_length,
     libewf_file_entry_t **file_entry,
     libcerror_error_t **error );

LIBEWF_EXTERN \
int libewf_handle_get_file_entry_by_utf16_path(
     libewf_handle_t *handle,
     const uint16_t *utf16_string,
     size_t utf16_string_length,
     libewf_file_entry_t **file_entry,
     libcerror_error_t **error );

#if defined( __cplusplus )
}
#endif

#endif /* !defined( _LIBEWF_INTERNAL_HANDLE_H ) */

