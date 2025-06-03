cmake_minimum_required(VERSION 3.14)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

if(NOT PROJECT_NAME)
    message("not project name")
    project(cicd)
    include(cmake/cmake_format.cmake)
endif()

# import tool include(common) # deprecate
include(add_src_exe) # deprecate
include(add_src_lib) # deprecate
include(add_dir_src)
include(add_dir_tests)
include(add_lib_exe)
include(add_test_exe)
include(fetch)
include(update_ws)
