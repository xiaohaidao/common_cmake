if(NOT PROJECT_IS_TOP_LEVEL)
    return()
endif()

message("check-memory found")
add_custom_target(
    check-memory
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_MEMORY_CHECKER=ON
            -S ${CMAKE_SOURCE_DIR}
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} -j
    COMMAND ${CMAKE_CTEST_COMMAND} -VV
    # COMMAND ${CMAKE_CTEST_COMMAND} -VV --test-dir ${CMAKE_BINARY_DIR} # 3.20
    # COMMAND ${CMAKE_CTEST_COMMAND} -VV --test-dir ${CMAKE_BINARY_DIR} -j #
    # 3.29
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_MEMORY_CHECKER=OFF
            -S ${CMAKE_SOURCE_DIR}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT " memory check")
add_custom_target(
    check-memory-cancel
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_MEMORY_CHECKER=OFF
            -S ${CMAKE_SOURCE_DIR}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "cancel memory check")

# gcc  -analysis -pg -fsanitize -cov
