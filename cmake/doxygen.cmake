find_package(Doxygen OPTIONAL_COMPONENTS dot mscgen dia)
if(NOT (PROJECT_IS_TOP_LEVEL AND DOXYGEN_FOUND))
    return()
endif()

message("doxygen found")
# set(DOXYGEN_EXCLUDE_PATTERNS  */build*/* */tests/*)
set(DOXYGEN_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/doxygen/)
if(EXISTS ${PROJECT_SOURCE_DIR}/docs/README.md)
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${PROJECT_SOURCE_DIR}/docs/README.md")
endif()

doxygen_add_docs(
    doxygen ${PROJECT_SOURCE_DIR}/docs/ ${PROJECT_SOURCE_DIR}/src/
    ${PROJECT_SOURCE_DIR}/include/
    COMMENT "Generate html pages for ${PROJECT_NAME}")
# install generated files
install(
    DIRECTORY ${DOXYGEN_OUTPUT_DIRECTORY}
    TYPE DOC
    OPTIONAL)
