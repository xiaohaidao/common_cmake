if(NOT get_cmake_version)
    set(get_cmake_version 0.1.0)
endif()

if(NOT GIT_COMMON_CMAKE_REPOSITORY)
    set(GIT_COMMON_CMAKE_REPOSITORY
        https://github.com/xiaohaidao/common_cmake.git)
endif()
if(NOT COMMON_CMAKE_VERSION)
    set(COMMON_CMAKE_VERSION dev)
endif()

if(NOT COMMAND fetch_add_packet)
    macro(fetch_add_packet_macro name)
        include(FetchContent)
        FetchContent_Declare(
            ${name}
            ${ARGN}
            GIT_SHALLOW ON
            GIT_PROGRESS ON)
        FetchContent_MakeAvailable(${name})
    endmacro()

    function(fetch_add_packet)
        set(FETCHCONTENT_UPDATES_DISCONNECTED ON)
        # or set(FETCHCONTENT_FULLY_DISCONNECTED OFF)
        fetch_add_packet_macro(${ARGV})
    endfunction()
endif()

if(NOT CUSTOM_COMMON_CMAKE)
    fetch_add_packet_macro(
        common_cmake GIT_REPOSITORY ${GIT_COMMON_CMAKE_REPOSITORY} GIT_TAG
        ${COMMON_CMAKE_VERSION})
    list(APPEND CMAKE_MODULE_PATH "${common_cmake_SOURCE_DIR}/cmake")

    # #import include
    include(include_cmake)
endif()

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
if(EXISTS ${PROJECT_SOURCE_DIR}/cmake/dependencies.cmake)
    configure_file(${PROJECT_SOURCE_DIR}/cmake/dependencies.cmake
                   cmake/dependencies_${PROJECT_NAME}.cmake)
endif()
if(EXISTS ${PROJECT_SOURCE_DIR}/cmake/dependencies_dev.cmake)
    configure_file(${PROJECT_SOURCE_DIR}/cmake/dependencies_dev.cmake
                   cmake/dependencies_dev_${PROJECT_NAME}.cmake)
endif()
list(APPEND CMAKE_MODULE_PATH "${PROJECT_BINARY_DIR}/cmake")
