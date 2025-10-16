if(NOT PROJECT_NAME)
    cmake_minimum_required(VERSION 3.14)

    project("project_test" VERSION 0.2.1)

    enable_testing()

    include(FetchContent)
    FetchContent_Declare(
        project_test_cpp
        SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../
        GIT_SHALLOW ON
        GIT_PROGRESS ON)
    FetchContent_MakeAvailable(project_test_cpp)
    # include(${CMAKE_CURRENT_LIST_DIR}/../cmake/get_cmake.cmake)
endif()

find_package(GTest REQUIRED)

add_test_exe(app_tests main.cpp)

target_compile_features(app_tests PRIVATE cxx_std_11)
target_link_libraries(
    app_tests PRIVATE GTest::gtest
                      # GTest::gtest_main GTest::gmock_main
)
