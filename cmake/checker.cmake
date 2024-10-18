include(${CMAKE_CURRENT_LIST_DIR}/clang_tidy.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/memory_checker.cmake)

add_custom_target(checker)
add_dependencies(checker clang-tidy)
