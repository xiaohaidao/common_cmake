find_program(CLANG_TIDY_TOOL clang-tidy)
if(NOT CLANG_TIDY_TOOL)
    return()
endif()
set(clang_tidy_target clang-tidy)
set(clang_tidy_cancel_target clang-tidy-cancel)
if(NOT PROJECT_IS_TOP_LEVEL)
    set(clang_tidy_target clang-tidy-${PROJECT_NAME})
    set(clang_tidy_cancel_target clang-tidy-cancel-${PROJECT_NAME})
else()
    set(CLANG_TIDY_TOOL "${CLANG_TIDY_TOOL}\;--fix\;--fix-errors")
    find_program(PY_COMPDB compdb)
    if(PY_COMPDB)
        set(COMPDB_COMMAND
            ${PY_COMPDB} -p ${CMAKE_BINARY_DIR} list >
            ${CMAKE_BINARY_DIR}/compile_commands_with_header.json && install
            ${CMAKE_BINARY_DIR}/compile_commands_with_header.json
            ${PROJECT_BINARY_DIR}/compile_commands.json)
    endif()
endif()

message("-- ${clang_tidy_target} found")
if(NOT PROJECT_IS_WORKSPACE)
    file_glob(CXX_FORMAT_FILES "*.h" "*.hpp" "*.cpp" "*.c")
endif()
add_custom_target(
    ${clang_tidy_target}
    COMMAND ${COMPDB_COMMAND}
    COMMAND clang-tidy --fix --fix-errors ${CXX_FORMAT_FILES}
            2>${PROJECT_BINARY_DIR}/clang-tidy-errors.log
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    COMMENT "Check code with ${clang_tidy_target}")

add_custom_target(
    ${clang_tidy_target}-cmake
    COMMAND
        ${CMAKE_COMMAND} -DCMAKE_C_CLANG_TIDY="${CLANG_TIDY_TOOL}"
        -DCMAKE_CXX_CLANG_TIDY="${CLANG_TIDY_TOOL}" -S${CMAKE_SOURCE_DIR}
        -B${CMAKE_BINARY_DIR}
    COMMAND ${CMAKE_COMMAND} --build ${PROJECT_BINARY_DIR} -j --target clean
    COMMAND ${COMPDB_COMMAND}
    COMMAND ${CMAKE_COMMAND} --build ${PROJECT_BINARY_DIR} -j
    COMMAND ${CMAKE_COMMAND} -DCMAKE_C_CLANG_TIDY="" -DCMAKE_CXX_CLANG_TIDY=""
            -S${CMAKE_SOURCE_DIR} -B${CMAKE_BINARY_DIR}
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    COMMENT "Check code with ${clang_tidy_target}")
add_custom_target(
    ${clang_tidy_cancel_target}
    COMMAND ${CMAKE_COMMAND} -DCMAKE_C_CLANG_TIDY="" -DCMAKE_CXX_CLANG_TIDY=""
            -S${CMAKE_SOURCE_DIR} -B${CMAKE_BINARY_DIR}
    COMMENT "Cancel ${clang_tidy_target}")
