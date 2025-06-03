include(${CMAKE_CURRENT_LIST_DIR}/doxygen.cmake)

if(NOT TARGET docs)
    add_custom_target(docs)
endif()
add_dependencies(docs ${doxygen_target})

