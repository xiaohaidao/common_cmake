
##
# @brief googletest
# @GIT_GOOGLETEST_REPOSITORY
# @GOOGLETEST_VERSION
# @GTEST_INSTALL_DIR
# link GTest:gtest
# link GTest:gtest_main
#
if (NOT GIT_GOOGLETEST_REPOSITORY)
    set(GIT_GOOGLETEST_REPOSITORY https://github.com/google/googletest.git)
endif()
if (NOT GOOGLETEST_VERSION)
    set(GOOGLETEST_VERSION release-1.10.0) # c++11
endif()

include(FetchContent)
FetchContent_Declare(
    googletest
    GIT_REPOSITORY ${GIT_GOOGLETEST_REPOSITORY}
    GIT_TAG ${GOOGLETEST_VERSION}
    GIT_SHALLOW ON
    GIT_PROGRESS ON
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
#set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_GetProperties(googletest)
if(NOT googletest_POPULATED)
    FetchContent_Populate(googletest)
    set(target_dir ${googletest_BINARY_DIR}/build/)
    set(src_dir ${googletest_SOURCE_DIR}/)
    if(NOT GTEST_INSTALL_DIR)
        set(install_dir ${target_dir}/install)
    else()
        set(install_dir ${GTEST_INSTALL_DIR})
    endif()

    RUN_CMD(
        COMMAND ${CMAKE_COMMAND} -B ${target_dir} .
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -Dgtest_force_shared_crt=ON
        WORKING_DIRECTORY ${src_dir}
    )
    RUN_CMD(
        COMMAND ${CMAKE_COMMAND} --build  ${target_dir} -j
        WORKING_DIRECTORY ${src_dir}
    )
    RUN_CMD(
        COMMAND ${CMAKE_COMMAND} --install ${target_dir} --prefix  ${install_dir}
        WORKING_DIRECTORY ${src_dir}
    )
    set(GTest_ROOT ${install_dir})
    set(GTest_DIR ${install_dir})
    find_package(GTest REQUIRED)
endif()
