
find_package(Doxygen OPTIONAL_COMPONENTS dot mscgen dia)

if(DOXYGEN_FOUND AND PROJECT_IS_TOP_LEVEL)
    # set(DOXYGEN_EXCLUDE_PATTERNS  */build*/* */tests/*)
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${PROJECT_SOURCE_DIR}/README.md")

    doxygen_add_docs(
        docs
        ${PROJECT_SOURCE_DIR}/docs/
        ${PROJECT_SOURCE_DIR}/src/
        ${PROJECT_SOURCE_DIR}/include/
        COMMENT "Generate html pages for ${PROJECT_NAME}"
    )
    # install generated files
    install(
        DIRECTORY ${PROJECT_BINARY_DIR}/html
        TYPE DOC
        OPTIONAL
    )
endif()