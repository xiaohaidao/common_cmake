find_program(CLANG_TIDY_TOOL clang-tidy)
if(NOT CLANG_TIDY_TOOL)
    return()
endif()
set(clang_tidy_target clang-tidy)
set(clang_tidy_cancel_target clang-tidy-cancel)
if(NOT PROJECT_IS_TOP_LEVEL)
    set(clang_tidy_target clang-tidy-${PROJECT_NAME})
    set(clang_tidy_cancel_target clang-tidy-cancel-${PROJECT_NAME})
endif()

message("${clang_tidy_target} found")
set(CLANG_TIDY_TOOL "${CLANG_TIDY_TOOL}\;--fix\;--fix-errors")

add_custom_target(
    ${clang_tidy_target}
    COMMAND
        ${CMAKE_COMMAND} -DCMAKE_C_CLANG_TIDY="${CLANG_TIDY_TOOL}"
        -DCMAKE_CXX_CLANG_TIDY="${CLANG_TIDY_TOOL}" -S${CMAKE_SOURCE_DIR}
        -B${CMAKE_BINARY_DIR}
    COMMAND ${CMAKE_COMMAND} --build ${PROJECT_BINARY_DIR} -j
    COMMAND ${CMAKE_COMMAND} -DCMAKE_C_CLANG_TIDY="" -DCMAKE_CXX_CLANG_TIDY=""
            -S${CMAKE_SOURCE_DIR} -B${CMAKE_BINARY_DIR}
    COMMENT "Check code with ${clang_tidy_target}")
add_custom_target(
    ${clang_tidy_cancel_target}
    COMMAND ${CMAKE_COMMAND} -DCMAKE_C_CLANG_TIDY="" -DCMAKE_CXX_CLANG_TIDY=""
            -S${CMAKE_SOURCE_DIR} -B${CMAKE_BINARY_DIR}
    COMMENT "Cancel ${clang_tidy_target}")
