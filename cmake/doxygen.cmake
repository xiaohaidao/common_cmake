find_package(Doxygen OPTIONAL_COMPONENTS dot mscgen dia)
if(NOT DOXYGEN_FOUND)
    return()
endif()
set(doxygen_target doxygen)
if(NOT PROJECT_IS_TOP_LEVEL)
    set(doxygen_target doxygen-${PROJECT_NAME})
endif()

message("-- ${doxygen_target} found")
# set(DOXYGEN_EXCLUDE_PATTERNS  */build*/* */tests/*)
set(DOXYGEN_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/doxygen/${PROJECT_NAME})
if(EXISTS ${PROJECT_SOURCE_DIR}/docs/README.md)
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${PROJECT_SOURCE_DIR}/docs/README.md")
endif()

doxygen_add_docs(
    ${doxygen_target} ${PROJECT_SOURCE_DIR}/docs/ ${PROJECT_SOURCE_DIR}/src/
    ${PROJECT_SOURCE_DIR}/include/
    COMMENT "Generate html pages for ${doxygen_target}")
# install generated files
install(
    DIRECTORY ${DOXYGEN_OUTPUT_DIRECTORY}/../
    TYPE DOC
    COMPONENT doc
    OPTIONAL)
