include(${CMAKE_CURRENT_LIST_DIR}/doxygen.cmake)

if(NOT TARGET docs)
    add_custom_target(docs)
endif()
if(TARGET ${doxygen_target})
    add_dependencies(docs ${doxygen_target})
endif()
