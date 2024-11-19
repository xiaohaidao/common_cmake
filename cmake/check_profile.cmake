if(NOT PROJECT_IS_TOP_LEVEL)
    return()
endif()
message("check-profile found")
add_custom_target(
    check-profile
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_PROFILE_CHECKER=ON -S ${CMAKE_SOURCE_DIR}
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} -j
    COMMAND ${CMAKE_CTEST_COMMAND} -VV
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_PROFILE_CHECKER=OFF -S ${CMAKE_SOURCE_DIR}
    # COMMAND gprof ${target} gmon.out
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT " profile check")

add_custom_target(
    check-profile-cancel
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_PROFILE_CHECKER=OFF -S ${CMAKE_SOURCE_DIR}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "cancel profile check")
