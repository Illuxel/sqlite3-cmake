cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

project(SqLite3Cmake 
    VERSION 3.42.0 
    LANGUAGES C
)

if (NOT DEFINED CMAKE_INSTALL_INCLUDEDIR)
    set(CMAKE_INSTALL_INCLUDEDIR "include")
endif()

if (NOT DEFINED CMAKE_INSTALL_LIBDIR)
    set(CMAKE_INSTALL_LIBDIR "lib")
endif()

if (NOT TARGET OPENSSL)
    find_package(OpenSSL REQUIRED)
#   find_package(ZLIB REQUIRED)
endif()

set(SQLITE3_INSTALL_INCLUDEDIR ${CMAKE_INSTALL_INCLUDEDIR}/sqlite3)

set(SQLITE3_INCLUDE
    sqlite3/sqlite3.h
    sqlite3/sqlite3ext.h
)
set(SQLITE3_SOURCE
    ${SQLITE3_INCLUDE}

    sqlite3/shell.c
    sqlite3/sqlite3.c
)

add_library(SqLite3 STATIC ${SQLITE3_SOURCE})
add_library(SqLite3::SqLite3 ALIAS SqLite3)

target_include_directories(SqLite3
PUBLIC 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
target_link_libraries(SqLite3
    OpenSSL::Crypto
    OpenSSL::SSL
)

install(
    TARGETS SqLite3 EXPORT sqlite3-targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
install(
    EXPORT sqlite3-targets 
    FILE sqlite3-targets.cmake
    NAMESPACE SqLite3::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/sqlite3
)

install(
    FILES ${SQLITE3_INCLUDE} 
    DESTINATION ${SQLITE3_INSTALL_INCLUDEDIR}
)

install(
    FILES cmake/sqlite3-config.cmake 
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/sqlite3
)
