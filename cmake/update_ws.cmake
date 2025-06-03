
add_custom_target(
    update-ws
    COMMAND python ${common_cmake_SOURCE_DIR}/concmake.py
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Update workspace CMakelists.txt")
