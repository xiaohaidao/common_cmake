include(${CMAKE_CURRENT_LIST_DIR}/clang_format.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmake_format.cmake)

add_custom_target(format)
add_dependencies(format clang-format)
add_dependencies(format cmake-format)
