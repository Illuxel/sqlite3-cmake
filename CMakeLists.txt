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
endif()

set(SQLITE3_INCLUDEDIR ${CMAKE_INSTALL_INCLUDEDIR}/sqlite3)

set(SQLITE3_INSTALL_INCLUDEDIR ${CMAKE_INSTALL_INCLUDEDIR}/cmake/sqlite3)
set(SQLITE3_INSTALL_LIBDIR ${CMAKE_INSTALL_LIBDIR}/cmake/sqlite3)

set(SQLITE3_INCLUDE
    sqlite3/sqlite3.h
    sqlite3/sqlite3ext.h
)
set(SQLITE3_SOURCE
    ${SQLITE3_INCLUDE}

    sqlite3/shell.c
    sqlite3/sqlite3.c
)

add_library(SQLite3 STATIC ${SQLITE3_SOURCE})
add_library(SQLite3::SQLite3 ALIAS SQLite3)

target_include_directories(SQLite3
PUBLIC 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
target_link_libraries(SQLite3
    OpenSSL::Crypto
    OpenSSL::SSL
)

install(
    TARGETS SQLite3 EXPORT sqlite3-targets
    LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(FILES ${SQLITE3_INCLUDE} DESTINATION ${SQLITE3_INCLUDEDIR})

include(CMakePackageConfigHelpers)
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/sqlite3-config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/sqlite3-config.cmake
    INSTALL_DESTINATION ${SQLITE3_INSTALL_LIBDIR}
    PATH_VARS
        CMAKE_INSTALL_LIBDIR
        CMAKE_INSTALL_INCLUDEDIR
)
write_basic_package_version_file(cmake/sqlite3-config-version.cmake
    VERSION ${SqLite3Cmake_VERSION}
    COMPATIBILITY ExactVersion
)

install(FILES 
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/sqlite3-config.cmake 
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/sqlite3-config-version.cmake 
DESTINATION ${SQLITE3_INSTALL_LIBDIR}
)

install(
    EXPORT sqlite3-targets 
    FILE sqlite3-targets.cmake
    NAMESPACE SQLite3::
    DESTINATION ${SQLITE3_INSTALL_LIBDIR}
)
