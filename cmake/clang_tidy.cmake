
find_program(CLANG_TIDY_TOOL clang-tidy)
if (PROJECT_IS_TOP_LEVEL AND CLANG_TIDY_TOOL)
add_custom_target(clang_tidy
    COMMAND
        ${CMAKE_COMMAND}
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
        -DCMAKE_C_CLANG_TIDY="${CLANG_TIDY_TOOL};--fix-errors"
        -DCMAKE_CXX_CLANG_TIDY="${CLANG_TIDY_TOOL};--fix-errors"
        -S${PROJECT_SOURCE_DIR} -B${PROJECT_BINARY_DIR}
    COMMAND ${CMAKE_COMMAND} --build ${PROJECT_BINARY_DIR} -j
    COMMENT "Check code with Clang-Tidy"
)
endif()
