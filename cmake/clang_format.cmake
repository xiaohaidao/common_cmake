find_program(CLANG_FORMAT_TOOL clang-format)
if(NOT CLANG_FORMAT_TOOL)
    return()
endif()
set(clang_format_target clang-format)
if(NOT PROJECT_IS_TOP_LEVEL)
    set(clang_format_target clang-format-${PROJECT_NAME})
endif()

include(file_glob)

message("${clang_format_target} program found")
file_glob(CXX_FORMAT_FILES "*.h" "*.hpp" "*.cpp" "*.c")
add_custom_target(
    ${clang_format_target}
    COMMAND ${CLANG_FORMAT_TOOL} -style=file -i ${CXX_FORMAT_FILES}
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
    COMMENT "Format code with ${clang_format_target}")
