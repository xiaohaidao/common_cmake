find_program(CMAKE_FORMAT_PROGRAM cmake-format)
if(NOT (PROJECT_IS_TOP_LEVEL AND CLANG_FORMAT_TOOL))
    return()
endif()

include(file_glob)

message("cmake-format program found")
file_glob(CMAKE_FILES "*.cmake" "CMakeLists.txt")

add_custom_target(
    cmake-format
    COMMAND ${CMAKE_FORMAT_PROGRAM} -i ${CMAKE_FILES}
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
    COMMENT "Format code with cmake-format")
