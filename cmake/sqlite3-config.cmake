@PACKAGE_INIT@

include(${CMAKE_CURRENT_LIST_DIR}/sqlite3-targets.cmake)
include(CMakeFindDependencyMacro)

find_dependency(OpenSSL)