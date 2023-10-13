
if (NOT GIT_GOOGLETEST_REPOSITORY)
    set(GIT_GOOGLETEST_REPOSITORY https://github.com/google/googletest.git)
endif()
if (NOT GOOGLETEST_VERSION)
    set(GOOGLETEST_VERSION release-1.10.0)
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
    execute_process(
        COMMAND ${CMAKE_COMMAND} -B ${target_dir} . -DCMAKE_BUILD_TYPE=Release
        WORKING_DIRECTORY ${googletest_SOURCE_DIR}
        # COMMAND_ECHO STDOUT
    )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build  ${target_dir} -j
        WORKING_DIRECTORY ${googletest_SOURCE_DIR}
    )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --install ${target_dir} --prefix  ${target_dir}/install
        WORKING_DIRECTORY ${googletest_SOURCE_DIR}
    )
    set(GTest_ROOT ${target_dir}/install/)
    set(GTest_DIR ${target_dir}/install/)
    find_package(GTest REQUIRED)
endif()
