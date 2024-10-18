cmake_minimum_required(VERSION 3.14)

project("library" VERSION 0.0.1)

# import common configure
if(NOT EXISTS ${CMAKE_BINARY_DIR}/RAPIDS.cmake)
    file(
        DOWNLOAD
        https://raw.githubusercontent.com/rapidsai/rapids-cmake/branch-24.02/RAPIDS.cmake
        ${CMAKE_BINARY_DIR}/RAPIDS.cmake)
endif()
# Initialize rapids-cmake
include(${CMAKE_BINARY_DIR}/RAPIDS.cmake)
