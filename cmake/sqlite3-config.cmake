@PACKAGE_INIT@

include(CMakeFindDependencyMacro)
include("${CMAKE_CURRENT_LIST_DIR}/sqlite3-targets.cmake")

check_required_components(@PROJECT_NAME@)