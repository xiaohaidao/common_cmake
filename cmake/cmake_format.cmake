find_program(CMAKE_FORMAT_PROGRAM cmake-format)
if(NOT CLANG_FORMAT_TOOL)
    return()
endif()
set(cmake_format_target cmake-format)
if(NOT PROJECT_IS_TOP_LEVEL)
    set(cmake_format_target cmake-format-${PROJECT_NAME})
    if (TARGET cmake-format)
        add_dependencies(cmake-format ${cmake_format_target})
    endif()
endif()

include(file_glob)
message("${cmake_format_target} program found")
file_glob(CMAKE_FILES "*.cmake" "CMakeLists.txt")

add_custom_target(
    ${cmake_format_target}
    COMMAND ${CMAKE_FORMAT_PROGRAM} -i ${CMAKE_FILES}
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
    COMMENT "Format code with ${cmake_format_target}")
