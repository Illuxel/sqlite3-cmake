cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

if (NOT DEFINED CMAKE_INSTALL_LIBDIR)
    set(CMAKE_INSTALL_LIBDIR "lib")
endif()

set(SQLITE3_INCLUDE
    include/sqlite3/sqlite3.h
    include/sqlite3/sqlite3ext.h
)
set(SQLITE3_SOURCE
    ${SQLITE3_INCLUDE}

    fl/db/private/sqlite3/shell.c
    fl/db/private/sqlite3/sqlite3.c
)

add_library(SqLite3 ALIAS SqLite3)
add_library(SqLite3 STATIC ${SQLITE3_SOURCE})