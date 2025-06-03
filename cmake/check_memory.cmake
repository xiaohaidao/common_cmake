include(check_memory_include)

set(check_memory_target check-memory)
set(check_memory_cancel_target check-memory-cancel)
if(NOT PROJECT_IS_TOP_LEVEL)
    set(check_memory_target check-memory-${PROJECT_NAME})
    set(check_memory_cancel_target check-memory-cancel-${PROJECT_NAME})
    if(TARGET check-memory)
        add_dependencies(check-memory ${check_memory_target})
        add_dependencies(check-memory-cancel ${check_memory_cancel_target})
    endif()
endif()

message("${check_memory_target} found")
add_custom_target(
    ${check_memory_target}
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_MEMORY_CHECKER=ON
            -S ${CMAKE_SOURCE_DIR}
    COMMAND ${CMAKE_COMMAND} --build ${PROJECT_BINARY_DIR} -j
    COMMAND ${CMAKE_CTEST_COMMAND} -VV
    # COMMAND ${CMAKE_CTEST_COMMAND} -VV --test-dir ${PROJECT_BINARY_DIR} # 3.20
    # COMMAND ${CMAKE_CTEST_COMMAND} -VV --test-dir ${PROJECT_BINARY_DIR} -j #
    # 3.29
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_MEMORY_CHECKER=OFF
            -S ${CMAKE_SOURCE_DIR}
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    COMMENT " memory check ${check_memory_target}")
add_custom_target(
    ${check_memory_cancel_target}
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_MEMORY_CHECKER=OFF
            -S ${CMAKE_SOURCE_DIR}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT " cancel memory check ${check_memory_target}")

# gcc  -analysis -pg -fsanitize -cov
