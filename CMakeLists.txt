cmake_minimum_required(VERSION 3.14)

if(NOT PROJECT_NAME)
    message("not project name")
    project(cicd)
endif()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

# import tool
include(fetch)
# include(common)
include(doxygen)
include(format)
include(checker)
