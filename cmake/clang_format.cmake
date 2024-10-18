find_program(CLANG_FORMAT_TOOL clang-format)
if(NOT (PROJECT_IS_TOP_LEVEL AND CLANG_FORMAT_TOOL))
    return()
endif()

include(file_glob)

message("clang-format program found")
file_glob(CXX_FORMAT_FILES "*.h" "*.hpp" "*.cpp" "*.c")
add_custom_target(
    clang-format
    COMMAND ${CLANG_FORMAT_TOOL} -style=file -i ${CXX_FORMAT_FILES}
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
    COMMENT "Format code with clang-format")
