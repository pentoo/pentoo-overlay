# - Try to find srsran
#
# Once done this will define
#  SRSRAN_FOUND        - System has srsran
#  SRSRAN_INCLUDE_DIRS - The srsran include directories
#  SRSRAN_LIBRARIES    - The srsran libraries
#
# The following variables are used:
#  SRSRAN_DIR          - Environment variable giving srsran install directory
#  SRSRAN_SRCDIR       - Directory containing srsran sources
#  SRSRAN_BUILDDIR     - Directory containing srsran build

#   /usr/lib64/libasn1_utils.a
#   /usr/lib64/libsrsran_mac.a
#   /usr/lib64/libnas_5g_msg.a
#   /usr/lib64/libsrsran_common.a
#   /usr/lib64/librrc_nr_asn1.a
#   /usr/lib64/libngap_nr_asn1.a
#   /usr/lib64/libs1ap_asn1.a
#   /usr/lib64/librrc_asn1.a
#   /usr/lib64/libsrsran_rlc.a
#   /usr/lib64/libsrsran_phy.a
#  /usr/lib64/libsrsran_pdcp.a
#   /usr/lib64/libsrsran_gtpu.a
#   /usr/lib64/libsrslog.a

find_package(PkgConfig)
pkg_check_modules(PC_SRSRAN QUIET srsran)
set(SRSRAN_DEFINITIONS ${PC_SRSRAN_CFLAGS_OTHER})

FIND_PATH(
    SRSRAN_INCLUDE_DIRS
    NAMES   srsran/srsran.h
    HINTS   $ENV{SRSRAN_DIR}/include
            ${SRSRAN_SRCDIR}/srsran/include
            ${PC_SRSRAN_INCLUDEDIR}
            ${CMAKE_INSTALL_PREFIX}/include
    PATHS   /usr/local/include
            /usr/include
)

FIND_LIBRARY(
    SRSRAN_LIBRARY
    NAMES   srsran_common
    HINTS   $ENV{SRSRAN_DIR}/lib
            ${SRSRAN_BUILDDIR}/srsran/lib
            ${PC_SRSRAN_LIBDIR}
            ${CMAKE_INSTALL_PREFIX}/lib
            ${CMAKE_INSTALL_PREFIX}/lib64
    PATHS   /usr/local/lib
            /usr/local/lib64
            /usr/lib
            /usr/lib64
)

FIND_LIBRARY(
    SRSRAN_LIBRARY_RADIO
    NAMES   srsran_radio
    HINTS   $ENV{SRSRAN_DIR}/lib
            ${SRSRAN_BUILDDIR}/srsran/lib
            ${PC_SRSRAN_LIBDIR}
            ${CMAKE_INSTALL_PREFIX}/lib
            ${CMAKE_INSTALL_PREFIX}/lib64
    PATHS   /usr/local/lib
            /usr/local/lib64
            /usr/lib
            /usr/lib64
)


#FIND_LIBRARY(
#    SRSRAN_LIBRARY_UPPER
#    NAMES   srsran_upper
#    HINTS   $ENV{SRSRAN_DIR}/lib
#            ${SRSRAN_BUILDDIR}/srsran/lib
#            ${PC_SRSRAN_LIBDIR}
#            ${CMAKE_INSTALL_PREFIX}/lib
#            ${CMAKE_INSTALL_PREFIX}/lib64
#    PATHS   /usr/local/lib
#            /usr/local/lib64
#            /usr/lib
#            /usr/lib64
#)

FIND_LIBRARY(
    SRSRAN_LIBRARY_ASN1
    NAMES   rrc_asn1
    HINTS   $ENV{SRSRAN_DIR}/lib
            ${SRSRAN_BUILDDIR}/srsran/lib
            ${PC_SRSRAN_LIBDIR}
            ${CMAKE_INSTALL_PREFIX}/lib
            ${CMAKE_INSTALL_PREFIX}/lib64
    PATHS   /usr/local/lib
            /usr/local/lib64
            /usr/lib
            /usr/lib64
)

FIND_LIBRARY(
    SRSRAN_LIBRARY_PHY
    NAMES   srsran_phy
    HINTS   $ENV{SRSRAN_DIR}/lib
            ${SRSRAN_BUILDDIR}/srsran/lib
            ${PC_SRSRAN_LIBDIR}
            ${CMAKE_INSTALL_PREFIX}/lib
            ${CMAKE_INSTALL_PREFIX}/lib64
    PATHS   /usr/local/lib
            /usr/local/lib64
            /usr/lib
            /usr/lib64
)

FIND_LIBRARY(
    SRSRAN_LIBRARY_RF
    NAMES   srsran_rf
    HINTS   $ENV{SRSRAN_DIR}/lib
            ${SRSRAN_BUILDDIR}/srsran/lib
            ${PC_SRSRAN_LIBDIR}
            ${CMAKE_INSTALL_PREFIX}/lib
            ${CMAKE_INSTALL_PREFIX}/lib64
    PATHS   /usr/local/lib
            /usr/local/lib64
            /usr/lib
            /usr/lib64
)

#FIND_LIBRARY(
#    SRSRAN_LIBRARY_RF_UTILS
#    NAMES   srsran_rf_utils
#    HINTS   $ENV{SRSRAN_DIR}/lib
#            ${SRSRAN_BUILDDIR}/srsran/lib
#            ${PC_SRSRAN_LIBDIR}
#            ${CMAKE_INSTALL_PREFIX}/lib
#            ${CMAKE_INSTALL_PREFIX}/lib64
#    PATHS   /usr/local/lib
#            /usr/local/lib64
#            /usr/lib
#            /usr/lib64
#)


IF(DEFINED SRSRAN_SRCDIR)
    set(SRSRAN_INCLUDE_DIRS ${SRSRAN_SRCDIR}/srsran
                            ${SRSRAN_SRCDIR}/cuhd
                            ${SRSRAN_SRCDIR}/common
                            ${SRSRAN_SRCDIR}/radio
                            ${SRSRAN_SRCDIR}/upper
                            ${SRSRAN_SRCDIR}/phy
                            ${SRSRAN_SRCDIR}/asn1)
ENDIF(DEFINED SRSRAN_SRCDIR)

#                            ${SRSRAN_LIBRARY_RF}
#                            ${SRSRAN_LIBRARY_RADIO}
set(SRSRAN_LIBRARIES        ${SRSRAN_LIBRARY}
                            ${SRSRAN_LIBRARY_RF_UTILS}
                            ${SRSRAN_LIBRARY_PHY}
#                            ${SRSRAN_LIBRARY_UPPER}
                            ${SRSRAN_LIBRARY_ASN1}
)

if(SRSRAN_LIBRARY_RF)
    list(APPEND SRSRAN_LIBRARIES ${SRSRAN_LIBRARY_RF})
endif(SRSRAN_LIBRARY_RF)

if(SRSRAN_LIBRARY_RADIO)
    list(APPEND SRSRAN_LIBRARIES ${SRSRAN_LIBRARY_RADIO})
endif(SRSRAN_LIBRARY_RADIO)

message(STATUS "SRSRAN LIBRARIES are: " ${SRSRAN_LIBRARIES})
message(STATUS "SRSRAN INCLUDE DIRS: " ${SRSRAN_INCLUDE_DIRS})

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(SRSRAN DEFAULT_MSG SRSRAN_LIBRARIES SRSRAN_INCLUDE_DIRS)
MARK_AS_ADVANCED(SRSRAN_LIBRARIES SRSRAN_INCLUDE_DIRS)
