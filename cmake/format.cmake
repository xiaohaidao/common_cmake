include(${CMAKE_CURRENT_LIST_DIR}/clang_format.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmake_format.cmake)

if (NOT TARGET format)
    add_custom_target(format)
endif()
add_dependencies(format ${clang_format_target})
add_dependencies(format ${cmake_format_target})
