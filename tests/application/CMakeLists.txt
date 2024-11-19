cmake_minimum_required(VERSION 3.14)

project("application" VERSION 0.0.1)

# import common configure
set(CUSTOM_LOCAL_COMMON_CMAKE ${CMAKE_CURRENT_LIST_DIR}/../../)
include(cmake/get_cmake.cmake)

include(use_project_top_dir)
