find_program(CLANG_FORMAT_TOOL clang-format)

if (PROJECT_IS_TOP_LEVEL AND CLANG_FORMAT_TOOL)

file(GLOB_RECURSE  cxx_format_files
    "include/*.h"
    "include/*.hpp"
    "example/*.h"
    "example/*.hpp"
    "example/*.cpp"
    "example/*.c"
    "src/*.h"
    "src/*.hpp"
    "src/*.cpp"
    "src/*.c"
    "tests/*.h"
    "tests/*.cpp"
)

add_custom_target(clang_format
    COMMAND ${CLANG_FORMAT_TOOL} -style=file -i ${cxx_format_files}
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
    COMMENT "Format code with clang-format"
)
endif()
