include(check_profile_include)

set(check_profile_target check-profile)
set(check_profile_cancel_target check-profile-cancel)
if(NOT PROJECT_IS_TOP_LEVEL)
    set(check_profile_target check-profile-${PROJECT_NAME})
    set(check_profile_cancel_target check-profile-cancel-${PROJECT_NAME})
endif()
message("${check_profile_target} found")
add_custom_target(
    ${check_profile_target}
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_PROFILE_CHECKER=ON
            -S ${CMAKE_SOURCE_DIR}
    COMMAND ${CMAKE_COMMAND} --build ${PROJECT_BINARY_DIR} -j
    COMMAND ${CMAKE_CTEST_COMMAND} -VV
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_PROFILE_CHECKER=OFF
            -S ${CMAKE_SOURCE_DIR}
    # COMMAND gprof ${target} gmon.out
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    COMMENT " profile check ${check_profile_target}")

add_custom_target(
    ${check_profile_cancel_target}
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_PROFILE_CHECKER=OFF
            -S ${CMAKE_SOURCE_DIR}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT " cancel profile check ${check_profile_target}")
