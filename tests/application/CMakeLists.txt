cmake_minimum_required(VERSION 3.14)

project("application" VERSION 0.0.1)

# import common configure
set(CUSTOM_COMMON_CMAKE ON)
include(cmake/get_cmake.cmake)
fetch_add_packet_macro(common_cmake SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../../)
list(APPEND CMAKE_MODULE_PATH "${common_cmake_SOURCE_DIR}/cmake")

# import common configure
include(include_cmake)

# import configure include(CPackSourceConfig)
include(package_dep_gtest)
include(package_dep_protobuf)
include(package_dep_grpc)

# import dependencies include(dependencies_${PROJECT_NAME})

add_subdirectory(src)

option(BUILD_TESTING "Build test" OFF)
include(CTest)
if(BUILD_TESTING AND PROJECT_IS_TOP_LEVEL)
    # include(dependencies_dev_${PROJECT_NAME})

    add_subdirectory(tests)
endif()
