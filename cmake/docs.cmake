include(${CMAKE_CURRENT_LIST_DIR}/doxygen.cmake)

add_custom_target(docs)
add_dependencies(docs doxygen)
